@isTest
private class TaskUtilTest {
    @isTest
    static void testTaskPriority(){
        string pri = TaskUtil.getTaskPriority('NY');
        system.assertEquals('Normal',pri);
        
    }
    
    @isTest
    static void testTaskHighPriority(){
        string pri = TaskUtil.getTaskPriority('CA');
        system.assertEquals('High',pri);
        
    }


    @isTest
    static void testTaskInvalidPriority(){
        string pri = TaskUtil.getTaskPriority('Montana');
        system.assertEquals(Null,pri);
        
    }

}