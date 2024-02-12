package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public var jumpPressed:Bool = FlxG.keys.pressed.SPACE;
	public var jumpTimer:Float = 0;
	public var jumping:Bool = false;

	public function new()
	{
		super();

		this.makeGraphic(64, 64, FlxColor.WHITE);

		this.acceleration.y = 550;
		this.maxVelocity.y = 450;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// Jumping

		// Other Movement
		if (FlxG.keys.pressed.A)
		{
			this.x -= 4;
		}
		else if (FlxG.keys.pressed.D)
		{
			this.x += 4;
		}
	}
}
