# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 6.2.0 - 2026-08-14

### Added

- Automated gem publication via
  [RubyGems trusted publishing](https://guides.rubygems.org/trusted-publishing/):
  pushing a `v*` tag builds and publishes the gem from GitHub Actions.

### Fixed

- Database connections are cached per database path, so multiple `Ziptz`
  instances pointing at different databases no longer share a connection.

## 6.1.0 - 2026-04-09

### Changed

- Unknown, invalid, and nil zip codes now raise `Ziptz::ZipNotFound` instead
  of returning nil.

### Removed

- Dropped support for Ruby 3.1 and 3.2; Ruby >= 3.3 is now required.

## 6.0.0 - 2024-12-27

### Changed

- **Breaking:** the gem no longer bundles zip code time zone data. Supply
  your own SQLite database and pass its path to `Ziptz.new`. See the
  [ZIP Code Time Zones Dataset](https://www.infused-data.com/zip-code-time-zones/).
- Database connections are cached per thread for thread safety.

### Removed

- The `Ziptz.instance` class method.

## 5.1.0 - 2024-04-28

### Changed

- sqlite3 dependency updated from `~> 1.6` to `~> 2.0` (#11).

## 5.0.0 - 2023-12-28

### Removed

- Dropped support for Rubies older than 3.1.
