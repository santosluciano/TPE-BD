/*
  Developed By Mahesh Hegde.
  Created Date : 16-May-2017
*/
(function($){
  'use strict';

  var _default = {
    yearStart: new Date(),
    yearEnd: new Date().setFullYear(new Date().getFullYear() + 1),
    weekDaysHolidays: [],
    publicHolidays: [],
    niwds: [],
    halfDays: [],
    noSchools: []
  };

  $.fn.fullYearCalendar = function(options) {
    options = $.extend(_default, options);
    this.each(function(index, element) {
      var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
      var content = $('<div class="row fyc-calendar"></div>');
      var monthContainer=""; var monthName = ""; var monthIndex = 0;
      var yearStart = moment(options.yearStart);
      var yearEnd = moment(options.yearEnd);
      if(yearStart._d.getHours() == 21){
        yearStart.add(3, 'h');
      }
      while(yearEnd.isAfter(yearStart)){
        monthIndex = yearStart.month();
        monthName = months[monthIndex];
        monthContainer = $('<div class="col-sm-12 table-responsive" id="'+ monthName +'"></div>');
        monthContainer.append(_getMonthTable(monthIndex, monthName, yearStart, options));
        content.append(monthContainer);
        yearStart.add(1, 'months');
      }
      $(element).append(content);
    });
    return {
      addHoliday: _addHoliday
    }
  }

  function _getMonthTable(monthIndex, monthName, yearStart, options) {
    var year = yearStart.year();
    var table = '<table class="table fyc-calendar-table"><thead><tr><th colspan="7" class="text-center">'+ monthName +' '+ year +'</th></tr>';
    table += '<tr><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th><th>Sun</th></tr></thead>';
    var tbody = _getMonthTableBody(monthIndex, year, options);
    table += tbody + '</table>';
    return table;
  }

  function _getMonthTableBody(monthIndex, year, options) {
    var tbody = '<tbody><tr>';
    var day = 1;
    var counter = 0;
    var numberOfDays = moment(''+ year +'-'+ (monthIndex + 1), 'YYYY-MM').daysInMonth();
    var firstDayOfMonth = moment([year, monthIndex]).day();
    if(firstDayOfMonth === 0){
      firstDayOfMonth = 7;
    }
    firstDayOfMonth--;
    while(firstDayOfMonth > 0){
      tbody += '<td></td>';
      firstDayOfMonth--;
      counter++;
    }
    while(day <= numberOfDays){
      if(counter > 6){
        counter = 0;
        tbody += '</tr><tr>';
      }
      var currentDate = moment(''+ year +'-'+ (monthIndex + 1) +'-'+ day, 'YYYY-MM-DD');
      var currentDateFormated = currentDate.format('YYYY-MM-DD');
      var classList = 'fyc-day ';
      if(options.weekDaysHolidays.indexOf(currentDate.day()) > -1 || options.noSchools.indexOf(currentDateFormated) > -1){
        classList += 'fyc-holiday ';
      }
      if(options.publicHolidays.indexOf(currentDateFormated) > -1){
        classList += 'fyc-public-holiday ';
      }
      if(options.niwds.indexOf(currentDateFormated) > -1) {
        classList += 'fyc-niwd-holiday ';
      }
      if(options.halfDays.indexOf(currentDateFormated) > -1) {
        classList += 'fyc-halfDay-holiday ';
      }
      tbody += '<td data-fyc-date=' + currentDateFormated + ' class="' + classList + '">' + day + '</td>';
      counter++;
      day++;
    }
    return tbody + '</tr></tbody>';
  }

  function _addHoliday(data){
    var className = "";
    switch (data.type) {
      case 'publicHolidays':
          className = "fyc-public-holiday";
        break;
        case 'niwds':
            className = "fyc-niwd-holiday";
          break;
          case 'halfDays':
              className = "fyc-halfDay-holiday";
            break;
      default:
        break;
    }
    var fromdate = moment(data.from, 'YYYY-MM-DD');
    if(data.to != undefined){
      var todate = moment(data.to, 'YYYY-MM-DD');
      while(todate >= fromdate){
        $('td[data-fyc-date=' + fromdate.format('YYYY-MM-DD') + ']').addClass(className);
        fromdate = fromdate.add(1, 'days');
      }
    } else {
      $('td[data-fyc-date=' + data.from + ']').addClass(className);
    }
  }

}(jQuery));
