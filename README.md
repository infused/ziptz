# Ziptz
[![Version](http://img.shields.io/gem/v/ziptz.svg?style=flat)](https://rubygems.org/gems/ziptz)
[![Build Status](https://github.com/infused/ziptz/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/infused/ziptz/actions/workflows/build.yml)
[![Total Downloads](https://img.shields.io/gem/dt/ziptz.svg)](https://rubygems.org/gems/ziptz/)
[![License](https://img.shields.io/github/license/infused/ziptz.svg)](https://github.com/infused/ziptz)

Get time zone, daylight saving time, and base offset for any US ZIP code.

<i>ZIP codes are up to date as of <b>May 2024</b>.</i>

## Compatibility

Ziptz is tested to work with the following versions of Ruby:

* Ruby 3.1.x, 3.2.x, 3.3.x

## Installation

Add the gem to your Gemfile:

    gem 'ziptz'

## Usage

Get the time zone name for any ZIP code:

    z = Ziptz.new
    z.time_zone_name('97213') #=> "America/Los_Angeles"

Get the time zone offset for any ZIP code:

    z.time_zone_offset('97213') #=> -28800

<em>Note that offsets do not include daylight saving time.</em>

Determine if the ZIP code uses Daylight Saving Time:

    z.time_zone_uses_dst?('97213') #=> true

Get all the zip codes in a time zone:

    z.zips('Pacific/Chuuk') #=> ["96942", "96943"]


## Supported Time Zones

* America/Adak
* America/Anchorage
* America/Boise
* America/Chicago
* America/Denver
* America/Detroit
* America/Indiana/Indianapolis
* America/Indiana/Knox
* America/Indiana/Marengo
* America/Indiana/Petersburg
* America/Indiana/Tell_City
* America/Indiana/Vevay
* America/Indiana/Vincennes
* America/Indiana/Winamac
* America/Juneau
* America/Kentucky/Louisville
* America/Kentucky/Monticello
* America/Los_Angeles
* America/Menominee
* America/Metlakatla
* America/New_York
* America/Nome
* America/North_Dakota/Beulah
* America/North_Dakota/Center
* America/North_Dakota/New_Salem
* America/Phoenix
* America/Puerto_Rico
* America/Sitka
* America/St_Thomas
* America/Yakutat
* Pacific/Chuuk
* Pacific/Guam
* Pacific/Honolulu
* Pacific/Kosrae
* Pacific/Kwajalein
* Pacific/Majuro
* Pacific/Pago_Pago
* Pacific/Palau
* Pacific/Pohnpei
* Pacific/Saipan
* Pacific/Wake

<em>Note that APO/FPO zip codes will not return a known time zone offset.</em>

## Prefer raw data?

If you would prefer raw data instead of a gem, see my [ZIP Code Time Zones](https://us-west-2.console.aws.amazon.com/dataexchange/home#/products/prodview-4vcapflqwntdw) product on AWS Data Exchange to subscribe.

## Version 3 breaking changes

* APO, DPO, and FPO zip codes are no longer included, because they are non-geographic.
* Time zone offsets are now specified in seconds instead of hours.
* Time zone are now more granular. The full list of time zones is:
  * America/Adak
  * America/Anchorage
  * America/Boise
  * America/Chicago
  * America/Denver
  * America/Detroit
  * America/Indiana/Indianapolis
  * America/Indiana/Knox
  * America/Indiana/Marengo
  * America/Indiana/Petersburg
  * America/Indiana/Tell_City
  * America/Indiana/Vevay
  * America/Indiana/Vincennes
  * America/Indiana/Winamac
  * America/Juneau
  * America/Kentucky/Louisville
  * America/Kentucky/Monticello
  * America/Los_Angeles
  * America/Menominee
  * America/Metlakatla
  * America/New_York
  * America/Nome
  * America/North_Dakota/Beulah
  * America/North_Dakota/Center
  * America/North_Dakota/New_Salem
  * America/Phoenix
  * America/Puerto_Rico
  * America/Sitka
  * America/St_Thomas
  * America/Yakutat
  * Pacific/Chuuk
  * Pacific/Guam
  * Pacific/Honolulu
  * Pacific/Kosrae
  * Pacific/Kwajalein
  * Pacific/Majuro
  * Pacific/Pago_Pago
  * Pacific/Palau
  * Pacific/Pohnpei
  * Pacific/Saipan
  * Pacific/Wake

## Version 2 breaking changes

Time zone names now reflect standard tz-database names.

| V1 Name | V2 Name |
| --- | --- |
| Atlantic | America/Puerto_Rico |
| Eastern | America/New_York |
| Central | America/Chicago |
| Mountain | America/Denver |
| Pacific | America/Los_Angeles |
| Hawaii-Aleutian Islands | Pacific/Honolulu or America/Adak |
| American Samoa | Pacific/Pago_Pago |
| Marshall Islands | Pacific/Majuro |
| Guam | Pacific/Guam |
| Palau | Pacific/Palau |
| Micronesia | Pacific/Pohnpei |

## License

  Copyright (c) 2015-2024 Keith Morrison <<keithm@infused.org>>

  Permission is hereby granted, free of charge, to any person
  obtaining a copy of this software and associated documentation
  files (the "Software"), to deal in the Software without
  restriction, including without limitation the rights to use,
  copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the
  Software is furnished to do so, subject to the following
  conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  OTHER DEALINGS IN THE SOFTWARE.
