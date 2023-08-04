@isTest
private class NPSIntegrationTest {
    
   
    @isTest
    static void testSendNPSData() {
        // Test data setup
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(AccountId = testAccount.Id, LastName = 'Test Contact', Email = 'test@example.com');
        insert testContact;

			// insert product
		Product2 p = new Product2();
	p.Name = ' Test Product ';
	p.Description='Test Product Entry For Product';
	p.productCode = 'SFDCPanther-123';
	p.isActive = true;
	insert p;

// insert pricebook entry for the product
		PricebookEntry standardPrice = new PricebookEntry();
	standardPrice.Pricebook2Id = Test.getStandardPricebookId();
	standardPrice.Product2Id = p.Id;
	standardPrice.UnitPrice = 100;
	standardPrice.IsActive = true;
		standardPrice.UseStandardPrice = false;
	insert standardPrice ;

        // Create the Contract record
        Contract testContract = new Contract(
            AccountId = testAccount.Id,
            StartDate = Date.today(),
            Status = 'Draft'
        );
        insert testContract;
	testcontract.status='Activated';
        update testcontract;
        // Create the Order record
        Order testOrder = new Order(
            AccountId = testAccount.Id,
            EffectiveDate = Date.today(),
            Status = 'Draft',
            Pricebook2Id = Test.getStandardPricebookId(),
            ContractId = testContract.Id // Set the ContractId field to relate the Contract to the Order
        );
        insert testOrder;

        // Create an OrderItem and associate it with the Order and Product
        OrderItem testOrderItem = new OrderItem(
            OrderId = testOrder.Id,
            PricebookEntryId = standardPrice.Id,
            Quantity = 2,
            UnitPrice = standardPrice.UnitPrice
        );
        insert testOrderItem;
		testorder.Status='fulfilment';
        update testorder;
        // Mock the HTTP callout to the NPS API
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Test.startTest();
        // Invoke the InvocableMethod
        List<string> errors = NPSIntegration.sendNPSData(new List<Id>{ testOrder.Id });
        Test.stopTest();

        // Perform assertions for successful execution
        System.assertEquals(0, errors.size(), 'No errors should be encountered.');
    }

 
}