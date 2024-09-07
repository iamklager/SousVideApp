# Sous Vide App
A simple mobile app to tell the time and temperature needed when cooking sous vide.


## DISCLAIMER

The times and temperatures shown in this app are only rough estimations and official temperature/time tables should be used to ensure one's food is safe for consumption!  

## Use Case \& Background

I like cooking sous vide, but I don't do it often enough to memorize times and temperatures. Pulling up tables is annoying, and having to convert Fahrenheit to Celsius is even worse. So I made an app that does it for me.

The app functions by selecting your type of meat and its thickness, and displays the necessary time and temperature of the sous vide bath.

Times estimated using a linear regression model trained on a set of temperature tables, and temperatures are being displayed in both Celsius and Fahrenheit.


## Technologies Used

- Python: + Kivy
- R
- Buildozer


## Implementation Details

### Time Estimation

To estimate the necessary time for each temperature and meat combination, a linear model was fitted.  

To leave room for errors, I ensured that most of the differences between common suggestions and the estimations were positive (hence, food would be cooked for longer than necessary, but not shorter), and the estimated times has been rounded up to 5 min intervals.

<p align = "center">
  <img src = "https://github.com/iamklager/SousVideApp/raw/main/.github/temp_diffs.png"/>
</p>

As only the model's coefficients needed to be included in the mobile app, and since R is my go-to language for statistics, data visualization, and reports (R Markdown), I used it over Python to fit the model.

### App Design

The app has been developed using the Kivy module for Python, and all of its elements were created using Kivy's native design language.

### Deployment

To port the app to mobile devices, I am using [Buildozer](https://buildozer.readthedocs.io/en/latest/). As the .spec file is provided in this repository, the app can easily be deployed to both Android and iOS by anyone.


## Demo Screenshots

<p align = "center">
  <img src = "https://github.com/iamklager/SousVideApp/raw/main/.github/screenshot_1.jpg" width = "400" />
  <img src = "https://github.com/iamklager/SousVideApp/raw/main/.github/screenshot_2.jpeg" width = "400" />
</p>
