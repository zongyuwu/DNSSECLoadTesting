# MailClinet  
Goal: response time of multiple user login at the same time

**FILE**  
  * Testing File  
    * Jmter_client_template.jmx : The jmeter testing template for mail client side. For diffierenet scale of log in. Change the thread number.  
      **Remember to disable graph result listener when load testing. [REF](https://blazemeter.com/blog/how-reduce-memory-usage-jmeter)**  
  
  * Report  
    *How to Read Report: Open Jmeter, then add a graph result listener, import the report into*  
    * report_$val.csv : $val user login at the same time

