extends ItemScript

func on_collect(_item: Item, _model: Node3D) -> void:
	setup()
 
func on_load(_item: Item) -> void:
	setup()

func setup() -> void:
	BattleService.s_battle_participant_died.connect(_participant_died)

func _participant_died(participant: Node3D) -> void:
	if participant is Cog and participant.dna:
		var POINT_AWARD = ceil(float(Util.floor_number) / 2)
		if participant.dna.is_mod_cog:
			POINT_AWARD += 1 
		print("POINT_AWARD: ", POINT_AWARD)
		print("FLOOR NUMBER: ", Util.floor_number)
		_award_points_to_all_tracks(POINT_AWARD)

func _award_points_to_all_tracks(points: int) -> void:
	var player = Util.get_player()
	#probably a better way to do this - oh well
	var all_tracks = ["Squirt", "Trap", "Lure", "Sound", "Throw", "Squirt", "Drop"]
	for track_name in all_tracks:
		if player.stats.gag_balance.has(track_name):
			player.stats.gag_balance[track_name] += points
