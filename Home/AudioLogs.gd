extends Window

var Player : AudioStreamPlayer2D
var Subtitles : RichTextLabel
var HzSlider : HSlider
var TimeStamp : RichTextLabel
var PlayPause : Button
var isPLaying : bool

var CurrentLine : int

var audio_length = 0

func kill():
	queue_free()

func _ready() -> void:
	Player =  $Player
	Subtitles = $Subtitles/Text
	HzSlider = $PlayPanel/Slider
	PlayPause = $PlayPanel/Button
	TimeStamp = $PlayPanel/Timestamp
	isPLaying = false
	CurrentLine = 0
	
	Subtitles.scroll_following = true
	#TEMP:
	LoadAudioFile(1)
	
	audio_length = Player.stream.get_length()
	HzSlider.min_value = 0
	HzSlider.max_value = audio_length

func LoadAudioFile(file : int):
	match file:
		1:
			pass
			#Player.stream = load("AudioFileGoeshere")
			#Load subtitles
	
func _process(delta: float):
	HzSlider.value = Player.get_playback_position()
	TimeStamp.text = formatTime(round(Player.get_playback_position())) + " / " + formatTime(round(audio_length))

func onSliderChanged(value):
	Player.seek(value)

func PlayPauseButtonPressed():
	if isPLaying:
		PlayPause.text = "⏵︎"
		isPLaying = false
		Player.stop()
		CurrentLine = 0
	else:
		PlayPause.text = "■"
		isPLaying = true
		Player.play()
		$Subtitles/Timer.start()
		Subtitles.scroll_to_line(0)

func formatTime(seconds : int) -> String:
	var minutes = seconds / 60
	var remaining = seconds % 60
	return str(minutes) + ":" + str(remaining).lpad(2,"0")
	
func ScrollSubtitles():
	if isPLaying && CurrentLine < Subtitles.get_line_count():
		print("scroll")
		Subtitles.scroll_to_line(CurrentLine)
		CurrentLine += 1
		$Subtitles/Timer.start()
