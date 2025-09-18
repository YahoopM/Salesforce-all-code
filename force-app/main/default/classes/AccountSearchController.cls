public with sharing class AccountSearchController {
    /**
     * Search Accounts by name (case-insensitive) and return commonly used fields.
     * - If keyword is blank, returns the first 50 accounts ordered by Name.
     */
    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccounts(String keyword) {
        String trimmed = keyword == null ? '' : keyword.trim();
        String likeExpr = '%' + String.escapeSingleQuotes(trimmed) + '%';

        if (String.isBlank(trimmed)) {
            return [
                SELECT Id, Name, Phone, Industry, Type, BillingCity, Website
                FROM Account
                ORDER BY Name
                LIMIT 50
            ];
        }

        return [
            SELECT Id, Name, Phone, Industry, Type, BillingCity, Website
            FROM Account
            WHERE Name LIKE :likeExpr
            ORDER BY Name
            LIMIT 50
        ];
    }
}


