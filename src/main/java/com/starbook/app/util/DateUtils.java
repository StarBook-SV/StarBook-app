package com.starbook.app.util;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

public class DateUtils {

    private final static String DATE_PATTERN = "dd.MM.yyyy";
    private final static String FORMAT_DATE_PATTERN = "dd-MM-yyyy";

    public static LocalDate parseLocalDate(String dateString) {
        return LocalDate.parse(dateString, DateTimeFormatter.ofPattern(DATE_PATTERN));
    }

    public static String formatLocalDate(LocalDate localDate) {
        return localDate.format(DateTimeFormatter.ofPattern(FORMAT_DATE_PATTERN));
    }

    public static java.util.Date toDate(LocalDate localDate) {
        return java.util.Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    public static LocalDate toLocalDate(java.util.Date date) {
        return date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
    }

    public static LocalDate toLocalDate(java.sql.Date date) {
        return toLocalDate(toUtilDate(date));
    }

    public static java.sql.Date toSqlDate(LocalDate localDate) {
        return new java.sql.Date(toDate(localDate).getTime());
    }

    public static java.sql.Date toSqlDate(java.util.Date date) {
        return new java.sql.Date(date.getTime());
    }

    public static java.util.Date toUtilDate(java.sql.Date date) {
        return new java.util.Date(date.getTime());
    }
}
