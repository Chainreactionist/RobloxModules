local SaveStructure = {
	Coins = 0;
	Xp = 0;
    Class = "Warrior";
	Inventory = {};
    LastPosition = {
        X = 0;
        Y = 0;
        Z = 0;
    };

    SkillBinds = {
        Attack1={
            Skill = "Basic Attack";
            KeyCode = Enum.KeyCode.One;
        };

        Attack2={
            Skill = "Attack";
            KeyCode = Enum.KeyCode.Two;
        };
        
        Attack3={
            Skill = "Basic Attack";
            KeyCode = Enum.KeyCode.Three;
        };
    };

    Quest = {}

}

return SaveStructure