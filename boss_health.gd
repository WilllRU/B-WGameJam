extends ProgressBar



func _on_MiniBoss_BossAwake(health):
	max_value = health
	value = 0
	for n in health +1:
		value += 1
		$HealthTimer.start(0.02); yield($HealthTimer,"timeout")
	pass # Replace with function body.

func _on_MiniBoss_BossHealth(health):
	value = health
	pass # Replace with function body.
