# Ziptz
[![Version](http://img.shields.io/gem/v/ziptz.svg?style=flat)](https://rubygems.org/gems/ziptz)
[![Build Status](http://img.shields.io/travis/infused/ziptz/master.svg?style=flat)](http://travis-ci.org/infused/ziptz)
[![Dependency Status](http://img.shields.io/gemnasium/infused/ziptz.svg?style=flat)](https://gemnasium.com/infused/ziptz)
[![Total Downloads](https://img.shields.io/gem/dt/ziptz.svg)](https://rubygems.org/gems/ziptz/)

Get time zone and daylight saving time for any US ZIP code.

<i>ZIP codes are up to date as of <b>August 2018</b>.</i>

## Installation

Add the gem to your Gemfile:

    gem 'ziptz'


## Usage

Get the time zone name for any ZIP code:

    z = Ziptz.new
    z.time_zone_name('97213') #=> "America/Los_Angeles"

Get the time zone offset for any ZIP code:

    z.time_zone_offset('97213') #=> -8

<em>Note that offsets do not include daylight saving time.</em>

Determine if the ZIP code uses Daylight Saving Time:

    z.time_zone_uses_dst?('97213') #=> true

Get all the zip codes in a time zone:

    z.zips('Pacific/Pago_Pago') #=> ["96799", "96941", "96942", "96943", "96944"]


## Supported Time Zones

* "America/Puerto_Rico" UTC -04:00
* "America/New_York" UTC -05:00
* "America/Chicago" UTC -06:00
* "America/Denver" UTC -07:00
* "America/Los_Angeles" UTC -08:00
* "America/Anchorage" UTC -09:00
* "Pacific/Honolulu" UTC -10:00
* "Pacific/Pago_Pago" UTC -11:00
* "Pacific/Majuro" UTC +12:00
* "Pacific/Guam" UTC +10:00
* "Pacific/Palau" UTC +09:00
* "Pacific/Pohnpei" UTC +11:00

<em>Note that APO/FPO zip codes will not return a known time zone offset.</em>

## Version 2 breaking changes

Time zone names now reflect standard tz-database names.

| V1 Name | V2 Name |
| --- | --- |
| Atlantic | America/Puerto_Rico |
| Eastern | America/New_York |
| Central | America/Chicago |
| Mountain | America/Denver |
| Pacific | America/Los_Angeles |
| Hawaii-Aleutian Islands | Pacific/Honolulu |
| American Samoa | Pacific/Pago_Pago |
| Marshall Islands | Pacific/Majuro |
| Guam | Pacific/Guam |
| Palau | Pacific/Palau |
| Micronesia | Pacific/Pohnpei |

## License

  Copyright (c) 2015-2018 Keith Morrison <<keithm@infused.org>>

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
