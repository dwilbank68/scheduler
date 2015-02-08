##When a unit_user is created

1.	its start time is set.
	1.	If it is the FIRST unit_user, start time set to current time
	2.	Otherwise, start time is set to the end time of the previous unit_user
1.	its end time is set by adding start time and duration
1.	Unit.duration is updated via a callback in unit_user.rb
	1.	to get the total queue duration, #update_total_time calls #get_total_time