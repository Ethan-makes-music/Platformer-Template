package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Enemy extends FlxSprite
{
	var direction:String = "left";

	public function new()
	{
		super(340, 120);

		this.makeGraphic(64, 64, FlxColor.RED);

		this.acceleration.y = 550;
		this.maxVelocity.y = 450;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (direction == "left")
		{
			this.x = this.x - 5;
		}
		else if (direction == "right")
		{
			this.x = this.x + 5;
		}

		if (this.x < -50 && direction == "left")
		{
			direction = "right";
		}
		else if (this.x > 600 && direction == "right")
		{
			direction = "left";
		}
	}
}
