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