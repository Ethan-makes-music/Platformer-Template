package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var ground:FlxSprite;
	var plr:FlxSprite;
	var jumpPressed:Bool = FlxG.keys.pressed.SPACE;
	var jumpTimer:Float = 0;
	var jumping:Bool = false;
	var enemy:FlxSprite;
	var attacking:Bool = false;
	var nextLevelSPR:FlxSprite = new FlxSprite(0, 356);
	var killsRequired:Int = 1;
	var howManyKillsTxt:FlxText;
	var howManyKillsNum:Int = 0;

	override public function create()
	{
		super.create();

		// Plr
		plr = new Player();
		plr.x = 150;
		add(plr);

		// enemy stuff
		enemy = new Enemy();
		add(enemy);

		// next level spr
		nextLevelSPR.makeGraphic(64, 64, FlxColor.GREEN);
		add(nextLevelSPR);

		// Ground
		ground = new FlxSprite(0, 420);
		ground.makeGraphic(FlxG.width, 64, FlxColor.GRAY);
		ground.immovable = true;
		add(ground);

		// how many kills
		howManyKillsTxt = new FlxText(0, 0, FlxG.width, "Kills needed: " + Std.string(killsRequired), 20);
		add(howManyKillsTxt);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(plr, ground);
		FlxG.collide(enemy, ground);

		howManyKillsTxt.text = "Kills needed: " + Std.string(killsRequired);

		// Plr Jump
		if (jumping && !FlxG.keys.justPressed.SPACE)
		{
			jumping = false;
		}

		if (plr.isTouching(DOWN) && !jumping)
		{
			jumpTimer = 0;
		}

		if (jumpTimer >= 0 && FlxG.keys.justPressed.SPACE)
		{
			jumping = true;
			jumpTimer += elapsed;
		}
		else
		{
			jumpTimer = -1;
		}

		if (jumpTimer > 0 && jumpTimer < 0.25)
		{
			plr.velocity.y = -360;
		}

		// Enemy collisoin
		if (FlxG.overlap(plr, enemy) && attacking == false)
		{
			FlxG.switchState(new LoseState());
		}
		else if (FlxG.overlap(plr, enemy) && attacking == true)
		{
			enemy.destroy();
			killsRequired = killsRequired - 1;
			howManyKillsNum = howManyKillsNum + 1;
		}
		else if (FlxG.overlap(plr, nextLevelSPR) && howManyKillsNum == 1)
		{
			FlxG.switchState(new WinState());
		}

		// Attacking
		if (FlxG.keys.pressed.SHIFT)
		{
			attacking = true;
		}
		else
		{
			attacking = false;
		}
	}
}
