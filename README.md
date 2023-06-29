# Bitcoin Price Alerts

Problem:
Create a price alert application that triggers an email when the user’s target price is
achieved.
Say, the current price of BTC is $28,000, a user sets an alert for BTC at a price of 33,000$.
The application should send an email to the user when the price of BTC reaches 33,000$.
Similarly, say, the current price of BTC is 35,000$, a user sets an alert for BTC at a price of
33,000$. The application should send an email when the price of BTC reaches 33,000$.

Things Implemented:
1. A Rails App backed by a postgres DB and Redis.
1. User registration system with Devise.
2. An API and a lighweight UI to view current setup alerts.
3. An API and a UI to create new alerts.
4. An API connection to fetch latest price alerts for Bitcoin.
5. An async process running on sidekiq which fetched latest price figures
    and loads them into Redis to be made available in Alerts module.
6. An alerts module which extracts users to whom the alerts need to be generated.


HLD of architrecture:

<img width="553" alt="Screenshot 2023-06-30 at 2 42 55 AM" src="https://github.com/Rishabh2991/btcAlerts/assets/22934371/8b3fbec8-401d-49d2-aadf-5eb15f114fc8">

Things pending.
1. A service to send out emails to users.

* Ruby version: 2.7.8p225
* Initialzing the app:
 - Install Docker
 - run ```docker compose up --build```

* Stack:
 - Rails - 6.0.6
 - Postgresql
 - Gems: 
   1. Devise [https://github.com/heartcombo/devise]
   2. Sidekiq 
   3. Redis-Rails 

* APIs integrated: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin"

* Notes and Assumptions:

1. This implementation depends on an API connection to fetch latest crypto price at short intervals and keep them into a readily accessible key value pair in a Redis cache. I can understand that webhook was the recommended source of pricing data, but In my opinion the rate at which webhooks will push data into this system and the volume of alerts which sidekiq will need to handle along with time will become a bottleneck in scaling.
2. The current implementation is ideal for a light weight alerting system for a small subset of users and can be scaled with a more structure redis cluster and sidekiq along with user volume.
3. In my experience sidekiq often tends to miss out on jobs in case of high volume of jobs in queues and in case of an alerting app it could lead to a bad customer experience. I believe a lamda based architecture is more suitable for this use case.
4. For time being I have left out the mailing feature out of this, but ideally I would have opted for some third party services like MailTrap etc.

![Screenshot 2023-06-30 at 2 27 46 AM](https://github.com/Rishabh2991/btcAlerts/assets/22934371/ba296e64-6913-479e-9347-2d61347f7566)

![Screenshot 2023-06-30 at 2 28 02 AM](https://github.com/Rishabh2991/btcAlerts/assets/22934371/654ffe80-3ed3-4e28-ae63-c84367b5df33)

<img width="1083" alt="Screenshot 2023-06-30 at 2 34 50 AM" src="https://github.com/Rishabh2991/btcAlerts/assets/22934371/0bcb4a73-e769-4167-8b41-228e65a586f3">


   
