# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  # fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  # fail "Unimplemented"
  this_string = page.body
  if this_string.include?(e1) & this_string.include?(e2)
    this_string.index(e1).should <= this_string.index(e2) 
  else
    fail "Movies not found"
  end
end


# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.delete!("\"")
  if uncheck.nil?
    rating_list.split(',').each do |rating|
      check("ratings["+rating.strip+"]")
    end
  else
    rating_list.split(',').each do |rating|
      uncheck("ratings["+rating.strip+"]")
    end
  end
end


Then /I should see all of the movies/ do
  all_movies = Movie.all
  all_rows = 11
  if all_movies.size == all_rows
    all_movies.each do |movie|
      assert page.body =~ /#{movie.title}/m
    end
  else
    false
  end
end

