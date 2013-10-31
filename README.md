---
languages: ruby
tags: ORM, ActiveRecord
---

# TV Land ActiveRecord Associations Lab

This lab is focused on something none of us have time to watch
anymore: TV. To keep track of what's out there, we'll build a small
database using ActiveRecord as our ORM.

The key things to think about here are relationships between concepts.
If we think in regular English about the concept of a network,
we'd say that a Network has many shows, and that each show has many
characters. We want to model our database the same way.

# Instructions

Fork and clone this repository, and get your rspec tests to pass.

You have rake tasks available to you: `rake db:migrate` and `rake
db:reset`. Don't forget to migrate your database!

The rspec tests are complete and should not need to change. You'll be
building migrations and filling in classes to get the tests to pass as
described.

Look at `spec/network_spec`, `app/models/network.rb`, and `db/migrate`
files to guide you. The network part of this lab is complete, the tests
pass, and the migrations are done. Use all of this as a reference
as you build out Show and Character.

You'll need to implement the code to pass the network, show, and
character specs, and then you'll need to use that knowledge to finish
the spec for actors and implement the actor model.

Some of the specs have TODOs to help guide you. Some do not. You'll
need to use what you know about ruby, objects, and ORMs to get them
to pass.

# Deliverable

Push your solution to the `master` branch of your fork.
