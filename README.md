# CODENAME FITNESS ASSIST

## How to Run

Bootstrap the project by running `melos bootstrap`

Start code gen by running `melos build_runner` or `melos watch_runner`

## Motivation

An app that would help track progress and keep historic data
Currently the implementation does not serve any logical function and is just for demostration purposes

## Technical Motiviation

Creating a lightweight sdk that would:

- Wrap a local database and expose an api for mutations and live database queries.
- Communicate with an endpoint that would be able to efficiently sync the data from and to the client.

### Technical highlights

- Riverpod state management
- Melos monorepo with apps and packages project structure
  - packages/core: contains the core app logic and UI
  - packages/lazy-sync: a sync client responsible for realtime local database and data sync from and to the server
  - packages/ui: contains UI primitives
- Go router navigation with indexed stack BottomNav navigation
- Custom widgets extending form fields
- freezed models
