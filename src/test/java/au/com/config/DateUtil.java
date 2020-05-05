package au.com.config;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
    public String getNextDay(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        Date date=new Date();
        calendar.add(Calendar.DAY_OF_YEAR,1);
        date=calendar.getTime();
        return sdf.format(calendar.getTime());
    }
}
