public with sharing class VoiceContactLookupController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> searchContactsForAccount(String prompt, Id accountId) {
        if (accountId == null) {
            throw new AuraHandledException('accountId is required.');
        }

        String cleaned = prompt == null ? '' : prompt.trim();
        if (String.isBlank(cleaned)) {
            return [
                SELECT Id, Name, Email, Phone, Title
                FROM Contact
                WHERE AccountId = :accountId
                ORDER BY LastModifiedDate DESC
                LIMIT 50
            ];
        }

        List<String> tokens = new List<String>();
        for (String t : cleaned.split('\\s+')) {
            if (String.isNotBlank(t)) tokens.add(t);
            if (tokens.size() == 5) break;
        }

        List<String> orClauses = new List<String>();
        for (String token : tokens) {
            String likeExpr = '%' + String.escapeSingleQuotes(token) + '%';
            orClauses.add('Name LIKE \'' + likeExpr + '\'');
            orClauses.add('Email LIKE \'' + likeExpr + '\'');
            orClauses.add('Phone LIKE \'' + likeExpr + '\'');
            orClauses.add('Title LIKE \'' + likeExpr + '\'');
        }

        String whereLike = orClauses.isEmpty() ? '' : '(' + String.join(orClauses, ' OR ') + ')';
        String whereAccount = 'AccountId = :accountId';
        String fullWhere = whereLike == '' ? whereAccount : whereAccount + ' AND ' + whereLike;

        String soql = 'SELECT Id, Name, Email, Phone, Title FROM Contact WHERE ' + fullWhere + ' ORDER BY LastModifiedDate DESC LIMIT 50';
        return Database.query(soql);
    }
}


