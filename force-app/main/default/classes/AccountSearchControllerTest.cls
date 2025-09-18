@IsTest
private class AccountSearchControllerTest {
    @IsTest
    static void search_withBlankKeyword_returnsLimitedAccounts() {
        // Arrange: create more than 1 account
        List<Account> seed = new List<Account>();
        for (Integer i = 0; i < 3; i++) {
            seed.add(new Account(Name = 'Acme ' + i, Phone = '123-456-789' + i, Industry = 'Technology', Type = 'Customer', BillingCity = 'City' + i, Website = 'https://example' + i + '.com'));
        }
        insert seed;

        Test.startTest();
        List<Account> results = AccountSearchController.searchAccounts('');
        Test.stopTest();

        System.assertNotEquals(null, results, 'Results should not be null');
        System.assert(results.size() > 0, 'Should return some accounts for blank keyword');
        System.assert(results.size() <= 50, 'Should limit results to 50');
        // Ensure common fields are accessible
        Account a = results[0];
        Object touchedFields = new List<Object>{ a.Name, a.Phone, a.Industry, a.Type, a.BillingCity, a.Website };
    }

    @IsTest
    static void search_withKeyword_filtersByName() {
        // Arrange: distinct names to filter by
        Account target = new Account(Name = 'ZZZ Special Target', Phone = '999-999-9999', Industry = 'Finance', Type = 'Prospect', BillingCity = 'Target City', Website = 'https://target.example.com');
        Account other = new Account(Name = 'Ordinary Name', Phone = '111-111-1111');
        insert new List<Account>{ target, other };

        Test.startTest();
        List<Account> filtered = AccountSearchController.searchAccounts('special');
        Test.stopTest();

        System.assertNotEquals(null, filtered, 'Filtered list should not be null');
        Boolean foundTarget = false;
        for (Account a : filtered) {
            if (a.Id == target.Id) {
                foundTarget = true;
            }
            // Touch selected fields for coverage
            Object touched = new List<Object>{ a.Name, a.Phone, a.Industry, a.Type, a.BillingCity, a.Website };
        }
        System.assert(foundTarget, 'Expected target account to be present for keyword match');
    }
}


