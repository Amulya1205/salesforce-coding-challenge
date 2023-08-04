

# Assumptions

1. Remote site settings is configured with the endpoint url to authorize the callout.
2. Error messages would be returned from the invocable class and would be utilized by admins through flow.

# solution
1. A basic record triggered flow 'Callout_to_NPS' is confgured to call the apex class 'NPS Integration'.
2. Invocable class NPS integration is configured to make a callout to NPS returning errors as List of strings.
3. Named credentials are configured to store user name and password for the site.


# Limitations:
1. Maximum number of http callouts allowed per transcation is 100.


# TO-D0
1. The created named credentials can be added to the code by querying them adding the named credential fields instead of user name and password.
2. In order to prevent multiple emails sent whenever the order status is changed to fulfilment, a field is to be created on order after the first email is sent to the contact.
3. Error handling can be made better by utilizing the error messages received from the class and display it accordingly through screen flow.



----------------------------------------------------------------------------------------------------------
# Salesforce Senior Coding Challenge

We appreciate you taking the time to participate and submit a coding challenge! 🥳

In the next step we would like you to implement a simple Invocable Apex Action to be used by your Admin colleagues for a Flow. They need to do HTTP callouts to a NPS Service, whenever an Order got fulfilled. Below you will find a list of tasks and optional bonus points required for completing the challenge.

**🚀 This is a template repo, just use the green button to create your own copy and get started!**

### Invocable:

* accepts the Order Record Ids as Input Parameter
* queries the required records to get the Bill To E-Mail Address (`Contact.Email`) and OrderNumber (`Order.OrderNumber`)
* sends the data to the NPS API
* add a basic Flow, that executes your Action whenever an Order Status is changed to `Fulfilled`

### The Mock NPS API:

* Hosted at https://salesforce-coding-challenge.herokuapp.com
* ✨[API Documentation](https://thermondo.github.io/salesforce-coding-challenge/)
* 🔐 uses HTTP Basic Auth, username: `tmondo`, password: `Noy84LRpYvMZuETB`

### ⚠️ Must Haves:

* [ ] use `sfdx` and `git`, commit all code and metadata needed (so we can test with a scratch org)
* [ ] write good meaningful unit tests
* [ ] properly separate concerns
* [ ] make a list of limitations/possible problems

### ✨ Bonus Points:

* [ ] layer your Code (use [apex-common](https://github.com/apex-enterprise-patterns/fflib-apex-common) if you like)
* [ ] use Inversion of Control to write true unit tests and not integration tests
* [ ] make sure customers don't get duplicate emails
* [ ] think of error handling and return them to the Flow for the Admins to handle

### What if I don't finish?

Finishing these tasks should take about 2-3 hours, but we are all about **'quality > speed'**, so it's better to deliver a clean MVP and leave some TODOs open.

Try to produce something that is at least minimally functional. Part of the exercise is to see what you prioritize first when you have a limited amount of time. For any unfinished tasks, please do add `TODO` comments to your code with a short explanation. You will be given an opportunity later to go into more detail and explain how you would go about finishing those tasks.