﻿Функция НашУчастник() Экспорт
	Возврат Константы.пНашУчастник.Получить();
КонецФункции

Функция ПостроитьДерево() Экспорт
	Результат = Новый ДеревоЗначений;
	Результат.Колонки.Добавить("Партия");
		//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	пПартия.Ссылка
		|ИЗ
		|	Справочник.пПартия КАК пПартия
		|ГДЕ
		|	пПартия.ПартияРодитель = &Родитель
		|	И пПартия.Участник = &Участник";
	
	Запрос.УстановитьПараметр("Родитель", Справочники.пПартия.ПустаяСсылка());
	Запрос.УстановитьПараметр("Участник", Константы.пНашУчастник.Получить());
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	Результат.Строки.Очистить();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Строка = Результат.Строки.Добавить();
		Строка.Партия = ВыборкаДетальныеЗаписи.Ссылка;
		ЗаполнитьДочерниеУзлы(Строка, ВыборкаДетальныеЗаписи.Ссылка);
	КонецЦикла;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
	
	Возврат Результат;
КонецФункции

Процедура ЗаполнитьДочерниеУзлы(РодительСтроки, РодительСсылка)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	пПартия.Ссылка
		|ИЗ
		|	Справочник.пПартия КАК пПартия
		|ГДЕ
		|	пПартия.ПартияРодитель = &Родитель";
	
	Запрос.УстановитьПараметр("Родитель", РодительСсылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Строка = РодительСтроки.Строки.Добавить();
		Строка.Партия = ВыборкаДетальныеЗаписи.Ссылка;
		ЗаполнитьДочерниеУзлы(Строка, ВыборкаДетальныеЗаписи.Ссылка)
	КонецЦикла;
КонецПроцедуры
