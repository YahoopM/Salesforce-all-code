public class DisplayInvoiceListTable {
    
    @AuraEnabled(cacheable=true)
    public static List<Invoice__c> getInvoiceList() {
        List<Invoice__c> invList = [
            SELECT Id,Name, Invoice_Date__c, Pending_Amount__c,
            Buyer_Name__c, Invoice_Status__c,
            Buyer_Name__r.Name, Buyer_Name__r.Id,Seller_Name__c,Seller_Name__r.Name,Seller_Name__r.Id
            FROM Invoice__c
            WHERE Invoice_Status__c IN ('New', 'Payment Pending')
        ];
        return invList;
    }
    
    @AuraEnabled(cacheable=false)
    public static List<Invoice_Line__c> getInvoiceLineById(Id invoiceId) {
        List<Invoice_Line__c> invLines = [
            SELECT Id, Name, Product_Name__c,Product_Name__r.Name,Product_Name__r.Id, Quantity__c, Price__c,
            Product_Total__c, Taxes__c, Grand_Total__c, Invoice__c
            FROM Invoice_Line__c
            WHERE Invoice__c = :invoiceId
            
        ];
        return invLines;
    }
    
    @AuraEnabled(Cacheable=true)
    public static List<Product2> getAllProducts(){
        return [SELECT Id, Name FROM Product2];
    }
    
    @AuraEnabled(cacheable=false)
    public static void saveInvoiceLine(List<Invoice_Line__c> invoiceLineList){
        System.debug('invoiceLineList '+invoiceLineList); 
        try{
            insert invoiceLineList;
        } catch(Exception e){
            String errorMessage = e.getMessage();
            System.debug('errorMessage ' + errorMessage);
        }
    }
    
    /* @AuraEnabled(cacheable=false)
public static void saveInvoiceLine(List<Invoice_Line__c> invoiceLineList) {
if (invoiceLineList == null || invoiceLineList.isEmpty()) {
throw new AuraHandledException('Invoice Line list is empty or null.');
}

try {
insert invoiceLineList;
} catch(Exception e) {
// throw new AuraHandledException('Failed to save invoice lines: ' + e.getMessage());
String errorMessage = e.getMessage();
system.debug('errorMessage  '+ e.getMessage());
}
}*/
    
}