package;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

using StringTools;

class StatsMenu extends MusicBeatState
{
	var grpMenuShit:FlxTypedGroup<FlxText>;

	var menuItems:Array<String> = ['Total notes hit: ' + FlxG.save.data.totalNotes, 'Total misses: ' + FlxG.save.data.totalMisses, 'Times played: ' + FlxG.save.data.timesPlayed];
	var curSelected:Int = 0;

	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/menuBG.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.6;
		bg.scrollFactor.set();
		add(bg);

		grpMenuShit = new FlxTypedGroup<FlxText>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			var songText:FlxText = new FlxText(0, (70 * i) + 30, 0, menuItems[i], 16);
			grpMenuShit.add(songText);
		}

		changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

        grpMenuShit.members[0].text = "Total notes hit: " + FlxG.save.data.totalNotes;
        grpMenuShit.members[1].text = "Total misses: " + FlxG.save.data.totalMisses;
        grpMenuShit.members[2].text = "Times played: " + FlxG.save.data.timesPlayed;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			FlxG.switchState(new OptionsMenu());
		}

        if (accepted){
            var selected:String = grpMenuShit.members[curSelected].text;

            if (selected.startsWith("Total notes"))
            {
                FlxG.save.data.totalNotes = 0;
            }
            if (selected.startsWith("Total misses"))
            {
                FlxG.save.data.totalMisses = 0;
            }
        }
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		for (item in grpMenuShit.members)
		{
			item.alpha = 0.6;
            grpMenuShit.members[curSelected].alpha = 1;
		}
	}
}
