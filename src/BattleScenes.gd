extends Control

signal enemy_defeated
signal textbox_closed

@export var Enemy: Resource = null

var defending = false
var tired = false

var w = 1

func _ready():
	set_health($EnemyContainer/Enemy/EnemyHP, Enemy.hp, Enemy.max_hp)
	$EnemyContainer/Enemy.texture = Enemy.texture
	set_health($PlayerContainer/PlayerC/PlayerHP, State.currenthp, State.maxhp)
	$EnemyContainer2.hide()
	$Textbox.hide()
	$ActionPanel.hide()
	$ActionPanel/Continue.hide()

	display_text("A wild %s appeared!" % Enemy.name.to_upper())
	
	await self.textbox_closed
	$ActionPanel.show()
	
	
func set_health(progress_bar, hp, maxhp):
	progress_bar.value = hp
	progress_bar.max_value = maxhp
	progress_bar.get_node("Lable").text = "HP: %d/%d" % [hp, maxhp]

func _input(_event):
	if (Input.is_action_just_pressed("ui_accept") and $Textbox.visible):
		$Textbox.hide()
		textbox_closed.emit()

func display_text(text):
	$ActionPanel.hide()
	$Textbox.show()
	$Textbox/Label.text = text

func enemy_turn():
		if(Enemy.hp==0):
			if(w>1):
				$EnemyContainer2.hide()
				display_text("%s was defeated! You Won! There is no more enemies left..." % Enemy.name.to_upper())
				await self.textbox_closed
				get_tree().quit()
			else:
				$AnimationPlayer.play("enemydeath")
				await $AnimationPlayer.animation_finished
				$EnemyContainer/Enemy.hide()
				display_text("%s was defeated! Congratulations!" % Enemy.name.to_upper())
				await self.textbox_closed
				$ActionPanel.show()
				$ActionPanel/Continue.show()
				$ActionPanel/q.hide()
				$ActionPanel/w.hide()
				$ActionPanel/e.hide()
				$ActionPanel/r.hide()
			
		elif(defending):
			defending = false
			display_text("%s attacks back!" % Enemy.name.to_upper())
			await self.textbox_closed
			display_text("%s's attack was deflected!" % Enemy.name.to_upper())
			$ActionPanel.show()
		else:
			display_text("%s attacks back!" % Enemy.name.to_upper())
			await self.textbox_closed
			State.currenthp = max(0, State.currenthp - Enemy.dmg)
			set_health($PlayerContainer/PlayerC/PlayerHP, State.currenthp, State.maxhp)
			$ActionPanel.show()
			if(State.currenthp==0):
				display_text("You were defeated")
				await self.textbox_closed
				get_tree().quit()

func _on_run_pressed():
	display_text("You ran away safely!")
	await self.textbox_closed
	get_tree().quit()

func _on_q_pressed():
	display_text("Your blast your opponent with flames!")
	await self.textbox_closed
	Enemy.hp = max(0, Enemy.hp - State.dmg*w)
	if(w>1):
		set_health($EnemyContainer2/Enemy/EnemyHP, Enemy.hp, Enemy.max_hp)
	else:
		set_health($EnemyContainer/Enemy/EnemyHP, Enemy.hp, Enemy.max_hp)
	$AnimationPlayer2.play("RESET")
	await $AnimationPlayer2.animation_finished
		
	enemy_turn()


func _on_w_pressed():
	tired = false
	display_text("You cleansed your wounds with water, and healed back some HP.")
	await self.textbox_closed
	var heal = 20*w
	if(heal+State.currenthp>State.maxhp):
		State.currenthp = State.maxhp
		set_health($PlayerContainer/PlayerC/PlayerHP, State.currenthp, State.maxhp)
	else: 
		State.currenthp+=heal
		set_health($PlayerContainer/PlayerC/PlayerHP, State.currenthp, State.maxhp)

	enemy_turn()

func _on_e_pressed():
	tired=false
	display_text("You harden your scales waiting for an attack...")
	await self.textbox_closed
	defending = true
	
	enemy_turn()


func _on_r_pressed():
	if(tired):
		display_text("You are too tired to do that again...")
		await self.textbox_closed
		$ActionPanel.show()
	else:
		tired = true
		display_text("Your unleash all your battle prowess for an ultimate show of power!!")
		await self.textbox_closed
		Enemy.hp = max(0, Enemy.hp - State.dmg*2*w)
		if(w>1):
			set_health($EnemyContainer2/Enemy/EnemyHP, Enemy.hp, Enemy.max_hp)
			
		else:
			set_health($EnemyContainer/Enemy/EnemyHP, Enemy.hp, Enemy.max_hp)
		$AnimationPlayer2.play("RESET")
		await $AnimationPlayer2.animation_finished
		display_text("You took recoil damage!")
		await self.textbox_closed
		State.currenthp-=(State.dmg*w/2)
		set_health($PlayerContainer/PlayerC/PlayerHP, State.currenthp, State.maxhp)
		enemy_turn()
	

func _on_continue_pressed():
	w+=0.5
	Enemy.max_hp += Enemy.dmg*2
	Enemy.hp=Enemy.max_hp
	Enemy.dmg = Enemy.dmg*2
	Enemy.name="Crawling Dragon"
	set_health($EnemyContainer2/Enemy/EnemyHP, Enemy.hp, Enemy.max_hp)
	$EnemyContainer2.show()
	$ActionPanel.show()
	$ActionPanel/Continue.hide()
	$ActionPanel/q.show()
	$ActionPanel/w.show()
	$ActionPanel/e.show()
	$ActionPanel/r.show()
	
