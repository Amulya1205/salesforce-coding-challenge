public with sharing class NPSIntegration {
    


    @InvocableMethod(label='Send NPS Data' description='Sends Order details to NPS API')
    public static List<string> sendNPSData(List<Id> orderIds) {
        List<string> errors = new List<string>();

        try {
            // Query the required fields
            List<Order> orders = [SELECT Id, BillToContact.Email, OrderNumber FROM Order WHERE Id IN :orderIds];

            // Prepare the data to send to the NPS API
            List<Map<String, Object>> npsDataList = new List<Map<String, Object>>();
            for (Order ord : orders) {
                Map<String, Object> npsData = new Map<String, Object>();
                npsData.put('sfId', ord.Id);
                npsData.put('orderNumber', ord.OrderNumber);
                npsData.put('customerEmail', ord.BillToContact.Email);
                
                npsDataList.add(npsData);
            }

            // Make the HTTP callout to the NPS API
            HttpResponse res = sendRequestToNPS(npsDataList);
            if (res.getStatusCode() != 200) {
                errors.add('NPS API returned an error with status code: ' + res.getStatusCode());
            } 
	        } catch (QueryException e) {
            errors.add('Error in query: ' + e.getMessage());
            
        } catch (CalloutException e) {
            errors.add('HTTP callout error: ' + e.getMessage());
        } catch (Exception e) {
            errors.add( 'Unexpected error: ' + e.getMessage());
        }

        return errors;
    }

    private static HttpResponse sendRequestToNPS(List<Map<String, Object>> npsDataList) {
        String endpoint = 'https://salesforce-coding-challenge.herokuapp.com/nps';
        String username = 'tmondo';
        String password = 'Noy84LRpYvMZuETB';

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json'); 
        req.setHeader('Authorization', 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(username + ':' + password)));

        String requestBody = JSON.serialize(npsDataList); // Serialize the data as JSON string
        req.setBody(requestBody);

        Http http = new Http();
        return http.send(req);
    }
}