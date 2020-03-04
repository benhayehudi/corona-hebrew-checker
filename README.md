# Corona Virus Health Advisory Diff Checker with SMS

This is a Ruby on Rails application that uses the [Nexmo SMS API](https://developer.nexmo.com) to check the [Israeli Ministry of Health](https://www.health.gov.il/Subjects/disease/corona/Pages/default.aspx) Corona Virus status page for any diffs in the past 24 hours. If there is a diff it sends out an update message by SMS to all those subscribed.

* Users can add themselves to the SMS list by visiting the top-level domain of the app and filling out the form.
* Users can remove themselves from the list by responding with the number `1`. 

## Installation and Usage

To use this application:

* Clone the repository locally
* Run `bundle install`
* Run `rake db:migrate`
* To setup the cron job locally on your machine run `whenever --update-crontab`
* To start the Rails server run `bundle exec rails s`

** Note: The Nexmo SMS API needs an externally accessible URL to send data to and interact with. For development purposes, [ngrok](https://ngrok.io) is a good tool. **

### Environment Variables

The app leverages three environment variables, which you need to provide the values for. As always, please do not commit your `.env` file to version control.

* NEXMO_API_KEY
* NEXMO_API_SECRET
* FROM_NUMBER

You can obtain your Nexmo API credentials and provision a Nexmo virtual phone number from within the [Nexmo Dashboard](https://dashboard.nexmo.com).

### Webhooks

The app has one route that is a webhook for the SMS API: `/webhooks/event`. From within the Nexmo Dashboard you can edit your virtual phone number settings to provide an *externally accessible* URL to the API. For example, if you are using ngrok, you would submit something like: `https://my-ngrok-url.ngrok.io/webhooks/event`.

## License

This app is licensed under the [MIT License](LICENSE.txt)

