#include <YSI\y_hooks>

hook OnGameModeInit()
{
	new
	    tmpobjid;

	// Interiér pro frakci Automechanik
 	tmpobjid = CreateDynamicObject(19650,2144.2841797,-1584.9169922,1783.5699463,0.0000000,0.0000000,0.0000000); //object(tubeflat25x25m1) (1)
    SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "CJ_blackplastic", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19650,2119.2998047,-1584.9199219,1783.5699463,0.0000000,0.0000000,0.0000000); //object(tubeflat25x25m1) (2)
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "CJ_blackplastic", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19456,2156.6992188,-1592.5996094,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall096) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2156.6992188,-1583.0000000,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall096) (2)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2151.7998047,-1597.3291016,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall096) (3)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2151.7998047,-1578.2724609,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall096) (4)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2142.1992188,-1597.3291016,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall096) (5)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2132.5996094,-1597.3291016,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall096) (6)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2123.0000000,-1597.3291016,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall096) (7)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19456,2113.3994141,-1597.3000488,1785.6999512,0.0000000,0.0000000,90.0000000); //object(wall096) (8)
	SetDynamicObjectMaterial(tmpobjid, 0, 10412, "hotel1", "carpet_red_256", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19456,2108.5566406,-1592.5996094,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall096) (9)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2108.5546875,-1583.0000000,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall096) (10)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19393,2145.3994141,-1578.2724609,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall041) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19364,2142.2197266,-1578.2724609,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall012) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2140.6992188,-1583.0498047,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall096) (11)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19393,2140.6992188,-1589.4492188,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall041) (2)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2135.8193359,-1578.2724609,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall096) (4)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19364,2149.7500000,-1579.9000244,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall012) (2)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19410,2149.7500000,-1583.0999756,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall058) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19364,2149.7500000,-1586.3000488,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall012) (3)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19364,2151.3999023,-1587.8149414,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall012) (4)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19393,2154.5996094,-1587.8144531,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall041) (3)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19437,2157.0000000,-1587.8149414,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall077) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2126.1999512,-1578.2724609,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall096) (4)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2116.5800781,-1578.2724609,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall096) (4)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19364,2110.1599121,-1578.2724609,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall012) (5)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(2185,2150.3486328,-1582.2500000,1783.7700195,0.0000000,0.0000000,270.0000000); //object(med_office6_desk_1) (1))
	SetDynamicObjectMaterial(tmpobjid, 2, 12954, "sw_furniture", "CJ_WOOD5", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 4, 9908, "smallertxd", "law_gazwhite3", 0xFFFFFFFF);

	CreateDynamicObject(19808,2150.6328125,-1583.1425781,1784.5899658,0.0000000,0.0000000,90.0000000); //object(keyboard1) (1)

	tmpobjid = CreateDynamicObject(1502,2153.8144531,-1587.8144531,1783.8199463,0.0000000,0.0000000,0.0000000); //object(gen_doorint04) (1)
	SetDynamicObjectMaterial(tmpobjid, 1, 5722, "sunrise01_lawn", "plainglass", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(1723,2141.5000000,-1587.1350098,1783.8199463,0.0000000,0.0000000,90.0000000); //object(mrk_seating1) (1)
    SetDynamicObjectMaterial(tmpobjid, 1, 12954, "sw_furniture", "CJ_WOOD5", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(1723,2141.5000000,-1582.1350098,1783.8199463,0.0000000,0.0000000,90.0000000); //object(mrk_seating1) (2)
    SetDynamicObjectMaterial(tmpobjid, 1, 12954, "sw_furniture", "CJ_WOOD5", 0xFFFFFFFF);

	CreateDynamicObject(2010,2141.6000977,-1583.5999756,1783.8000488,0.0000000,0.0000000,0.0000000); //object(nu_plant3_ofc) (1)

	tmpobjid = CreateDynamicObject(1502,2140.6992188,-1590.1899414,1783.8199463,0.0000000,0.0000000,90.0000000); //object(gen_doorint04) (3)
	SetDynamicObjectMaterial(tmpobjid, 1, 5722, "sunrise01_lawn", "plainglass", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19456,2145.5996094,-1591.5498047,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall096) (3)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19858,2146.1298828,-1578.2724609,1785.0749512,0.0000000,0.0000000,180.0000000); //object(mihouse1door2) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 4572, "stolenbuild02", "sl_dtdoor1", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19456,2132.5996094,-1597.3291016,1789.0500488,0.0000000,0.0000000,90.0000000); //object(wall096) (6)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2123.0000000,-1597.3291016,1789.0500488,0.0000000,0.0000000,90.0000000); //object(wall096) (7)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2113.3994141,-1597.3291016,1789.0500488,0.0000000,0.0000000,90.0000000); //object(wall096) (8)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2108.5566406,-1592.5996094,1789.0500488,0.0000000,0.0000000,0.0000000); //object(wall096) (9)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2108.5546875,-1583.0000000,1789.0500488,0.0000000,0.0000000,0.0000000); //object(wall096) (10)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2136.2709961,-1583.0498047,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall096) (11)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19393,2136.2709961,-1589.4499512,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall041) (5)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2136.2709961,-1595.8499756,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall096) (11)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(1502,2136.2709961,-1588.6600342,1783.8199463,0.0000000,0.0000000,270.0000000); //object(gen_doorint04) (5)
	SetDynamicObjectMaterial(tmpobjid, 1, 5722, "sunrise01_lawn", "plainglass", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19456,2113.3999023,-1578.2724609,1789.0500488,0.0000000,0.0000000,90.0000000); //object(wall096) (4)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2123.0200195,-1578.2724609,1789.0500488,0.0000000,0.0000000,90.0000000); //object(wall096) (4)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2132.6499023,-1578.2724609,1789.0500488,0.0000000,0.0000000,90.0000000); //object(wall096) (4)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2136.2705078,-1583.0498047,1789.0500488,0.0000000,0.0000000,0.0000000); //object(wall096) (11)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2136.2709961,-1592.6800537,1789.0500488,0.0000000,0.0000000,0.0000000); //object(wall096) (11)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19393,2147.5673828,-1593.1992188,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall041) (6)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19364,2147.5673828,-1596.3994141,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall012) (8)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19393,2137.8420410,-1585.5009766,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall041) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19437,2139.9492188,-1585.5009766,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall077) (2)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);

	CreateDynamicObject(11729,2145.4760742,-1596.9000244,1783.8199463,0.0000000,0.0000000,179.9945068); //object(gymlockerclosed1) (2)
	CreateDynamicObject(11729,2144.6699219,-1596.9000244,1783.8199463,0.0000000,0.0000000,179.9945068); //object(gymlockerclosed1) (3)
	CreateDynamicObject(11729,2143.8500977,-1596.9000244,1783.8199463,0.0000000,0.0000000,180.0000000); //object(gymlockerclosed1) (4)
	CreateDynamicObject(11729,2143.0000000,-1596.9000244,1783.8199463,0.0000000,0.0000000,179.9945068); //object(gymlockerclosed1) (5)
	CreateDynamicObject(11729,2142.1599121,-1596.9000244,1783.8199463,0.0000000,0.0000000,179.9945068); //object(gymlockerclosed1) (6)

	tmpobjid = CreateDynamicObject(1280,2147.1499023,-1595.5899658,1784.2209473,0.0000000,0.0000000,0.0000000); //object(parkbench1) (2)
	SetDynamicObjectMaterial(tmpobjid, 1, 12954, "sw_furniture", "CJ_WOOD5", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(1280,2142.8798828,-1594.1497803,1784.2209473,0.0000000,0.0000000,270.0000000); //object(parkbench1) (4)
	SetDynamicObjectMaterial(tmpobjid, 1, 12954, "sw_furniture", "CJ_WOOD5", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(1502,2147.5673828,-1592.4100342,1783.8199463,0.0000000,0.0000000,270.0000000); //object(gen_doorint04) (6)
	SetDynamicObjectMaterial(tmpobjid, 1, 5722, "sunrise01_lawn", "plainglass", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(1502,2137.0700684,-1585.5009766,1783.8199463,0.0000000,0.0000000,0.0000000); //object(gen_doorint04) (7)
	SetDynamicObjectMaterial(tmpobjid, 1, 5722, "sunrise01_lawn", "plainglass", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(3055,2129.3520508,-1578.3000488,1786.0179443,0.0000000,0.0000000,0.0000000); //object(kmb_shutter) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 11395, "corvinsign_sfse", "shutters", 0xFFFFFFFF);

	CreateDynamicObject(11729,2146.2849121,-1592.0000000,1783.8199463,0.0000000,0.0000000,0.0000000); //object(gymlockerclosed1) (7)
	CreateDynamicObject(11729,2145.4760742,-1592.0000000,1783.8199463,0.0000000,0.0000000,0.0000000); //object(gymlockerclosed1) (8)
	CreateDynamicObject(11729,2144.6699219,-1592.0000000,1783.8199463,0.0000000,0.0000000,0.0000000); //object(gymlockerclosed1) (9)
	CreateDynamicObject(11729,2143.8500977,-1592.0000000,1783.8199463,0.0000000,0.0000000,0.0000000); //object(gymlockerclosed1) (10)
	CreateDynamicObject(11729,2143.0000000,-1592.0000000,1783.8199463,0.0000000,0.0000000,0.0000000); //object(gymlockerclosed1) (11)
	CreateDynamicObject(11729,2142.1599121,-1592.0000000,1783.8199463,0.0000000,0.0000000,0.0000000); //object(gymlockerclosed1) (12)
	CreateDynamicObject(1776,2146.3000488,-1591.0000000,1784.9189453,0.0000000,0.0000000,180.0000000); //object(cj_candyvendor) (1)
	CreateDynamicObject(1775,2144.8999023,-1591.0000000,1784.9169922,0.0000000,0.0000000,180.0000000); //object(cj_sprunk1) (1)
	CreateDynamicObject(2010,2155.9687500,-1590.8798828,1783.8000488,0.0000000,0.0000000,0.0000000); //object(nu_plant3_ofc) (2)

	tmpobjid = CreateDynamicObject(19456,2155.1999512,-1591.5498047,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall096) (3)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19393,2140.6992188,-1595.8499756,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall041) (2)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19364,2140.6992188,-1592.6600342,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall012) (8)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(1502,2140.6992188,-1595.0620117,1783.8199463,0.0000000,0.0000000,270.0000000); //object(gen_doorint04) (6)
	SetDynamicObjectMaterial(tmpobjid, 1, 5722, "sunrise01_lawn", "plainglass", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19603,2154.2250977,-1597.0899658,1783.8289795,0.0000000,0.0000000,0.0000000); //object(waterplane1) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 3947, "rczero_track", "waterclear256", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19364,2151.6499023,-1596.1949463,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall012) (9)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19364,2154.1499023,-1596.1949463,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall012) (10)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2156.5500488,-1594.6755371,1782.1999512,0.0000000,0.0000000,90.0000000); //object(wall096) (3)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);

	CreateDynamicObject(11707,2156.5791016,-1595.3499756,1785.4410400,0.0000000,0.0000000,90.0000000); //object(towelrack1) (1)
	CreateDynamicObject(11707,2154.0200195,-1595.3499756,1785.4410400,0.0000000,0.0000000,90.0000000); //object(towelrack1) (2)
	CreateDynamicObject(2817,2154.9008789,-1594.5429688,1783.8199463,0.0000000,0.0000000,0.0000000); //object(gb_bedrug01) (1)
	CreateDynamicObject(2817,2152.3579102,-1594.5600586,1783.8199463,0.0000000,0.0000000,0.0000000); //object(gb_bedrug01) (2)

	tmpobjid = CreateDynamicObject(19437,2150.7800293,-1595.8000488,1783.2500000,0.0000000,0.0000000,90.0000000); //object(wall077) (4)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);

	CreateDynamicObject(2528,2151.0920410,-1596.5600586,1783.8199463,0.0000000,0.0000000,270.0000000); //object(cj_toilet3) (1)
	CreateDynamicObject(19873,2151.4799805,-1596.4179688,1784.8239746,0.0000000,0.0000000,0.0000000); //object(toiletpaperroll1) (1)
	CreateDynamicObject(19874,2155.0209961,-1596.5479736,1783.8289795,0.0000000,0.0000000,315.0000000); //object(soapbar1) (1)
	CreateDynamicObject(2523,2149.0700684,-1592.1800537,1783.8199463,0.0000000,0.0000000,0.0000000); //object(cj_b_sink3) (1)
	CreateDynamicObject(1421,2151.6899414,-1588.3959961,1784.5830078,0.0000000,0.0000000,0.0000000); //object(dyn_boxes) (1)

	tmpobjid = CreateDynamicObject(19393,2155.0000000,-1584.1049805,1785.5699463,0.0000000,0.0000000,90.0000000); //object(wall041) (3)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2153.4851074,-1579.1989746,1785.5699463,0.0000000,0.0000000,0.0000000); //object(wall096) (2)
	SetDynamicObjectMaterial(tmpobjid, 0, 8498, "excalibur", "excaliburwall01_128", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(1502,2154.2199707,-1584.1049805,1783.8199463,0.0000000,0.0000000,0.0000000); //object(gen_doorint04) (1)
	SetDynamicObjectMaterial(tmpobjid, 1, 5722, "sunrise01_lawn", "plainglass", 0xFFFFFFFF);

	CreateDynamicObject(2161,2151.4550781,-1578.4000244,1783.8199463,0.0000000,0.0000000,0.0000000); //object(med_office_unit_4) (1)
	CreateDynamicObject(2523,2154.0900879,-1582.5000000,1783.8199463,0.0000000,0.0000000,90.0000000); //object(cj_b_sink3) (2)
	CreateDynamicObject(1778,2153.5249023,-1582.6999512,1783.8199463,0.0000000,0.0000000,100.0000000); //object(cj_mop_pail) (2)
	CreateDynamicObject(2164,2152.2500000,-1587.6999512,1783.8199463,0.0000000,0.0000000,180.0000000); //object(med_office_unit_5) (1)
	CreateDynamicObject(1714,2151.5500488,-1582.5500488,1783.7900391,0.0000000,0.0000000,319.9987793); //object(kb_swivelchair1) (1)
	CreateDynamicObject(1714,2150.9460449,-1579.9420166,1783.7900391,0.0000000,0.0000000,35.0000000); //object(kb_swivelchair1) (2)
	CreateDynamicObject(11392,2128.9060059,-1583.8289795,1783.8199463,0.0000000,0.0000000,0.0000000); //object(hubfloorstains_sfse) (1)
	CreateDynamicObject(11392,2111.2758789,-1591.6059570,1783.8199463,0.0000000,0.0000000,0.0000000); //object(hubfloorstains_sfse) (2)

	tmpobjid = CreateDynamicObject(19817,2115.9189453,-1584.0000000,1782.9000244,0.0000000,0.0000000,90.0000000); //object(carfixerramp1) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 10412, "hotel1", "carpet_red_256", 0xFFFFFFFF);

	CreateDynamicObject(19903,2112.1679688,-1586.4000244,1783.8199463,0.0000000,0.0000000,5.0000000); //object(mechaniccomputer1) (2)
	CreateDynamicObject(19899,2109.1499023,-1580.6500244,1783.8199463,0.0000000,0.0000000,0.0000000); //object(toolcabinet1) (2)
	CreateDynamicObject(19815,2113.0639648,-1578.3580322,1785.2399902,0.0000000,0.0000000,0.0000000); //object(toolboard1) (1)

	tmpobjid = CreateDynamicObject(19817,2129.5000000,-1593.3000488,1782.9000244,0.0000000,0.0000000,260.0000000); //object(carfixerramp1) (3)
	SetDynamicObjectMaterial(tmpobjid, 0, 10412, "hotel1", "carpet_red_256", 0xFFFFFFFF);

	CreateDynamicObject(19903,2134.0820312,-1591.9000244,1783.8199463,0.0000000,0.0000000,175.0000000); //object(mechaniccomputer1) (3)
	CreateDynamicObject(19899,2129.0000000,-1596.7500000,1783.8199463,0.0000000,0.0000000,90.0000000); //object(toolcabinet1) (3)
	CreateDynamicObject(19900,2133.9628906,-1591.0429688,1783.8199463,0.0000000,0.0000000,0.0000000); //object(toolcabinet2) (1)
	CreateDynamicObject(19900,2116.8999023,-1578.6999512,1783.8199463,0.0000000,0.0000000,0.0000000); //object(toolcabinet2) (2)
	CreateDynamicObject(3632,2130.8620605,-1596.7509766,1784.2950439,0.0000000,0.0000000,0.0000000); //object(imoildrum_las) (1)
	CreateDynamicObject(19815,2136.1850586,-1594.2969971,1785.2299805,0.0000000,0.0000000,270.0000000); //object(toolboard1) (3)
	CreateDynamicObject(3593,2135.5000000,-1583.3370361,1785.0999756,0.0000000,275.0000000,0.0000000); //object(la_fuckcar2) (1)
	CreateDynamicObject(17969,2136.1621094,-1593.7180176,1785.1960449,0.0000000,0.0000000,0.0000000); //object(hub_graffitti) (1)
	CreateDynamicObject(1372,2122.8759766,-1578.7889404,1783.8199463,0.0000000,0.0000000,0.0000000); //object(cj_dump2_low) (2)
	CreateDynamicObject(1372,2120.8999023,-1578.7889404,1783.8199463,0.0000000,0.0000000,0.0000000); //object(cj_dump2_low) (3)
	CreateDynamicObject(1810,2115.8896484,-1579.3935547,1783.8199463,0.0000000,0.0000000,0.0000000); //object(cj_foldchair) (1)

	tmpobjid = CreateDynamicObject(19454,2113.3000488,-1595.5899658,1783.8499756,0.0000000,90.0000000,90.0000000); //object(wall094) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 5532, "paynspray_lae", "sf_spray_floor1", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19454,2113.3000488,-1592.0999756,1783.8499756,0.0000000,90.0000000,90.0000000); //object(wall094) (2)
	SetDynamicObjectMaterial(tmpobjid, 0, 5532, "paynspray_lae", "sf_spray_floor1", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19456,2113.4799805,-1590.3399658,1785.6860352,0.0000000,0.0000000,90.0000000); //object(wall096) (12)
	SetDynamicObjectMaterial(tmpobjid, 0, 10412, "hotel1", "carpet_red_256", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19437,2118.2099609,-1597.3900146,1785.6860352,0.0000000,0.0000000,0.0000000); //object(wall077) (3)
	SetDynamicObjectMaterial(tmpobjid, 0, 10412, "hotel1", "carpet_red_256", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19437,2116.5280762,-1592.3850098,1783.9000244,0.0000000,90.0000000,0.0000000); //object(wall077) (5)
	SetDynamicObjectMaterial(tmpobjid, 0, 5532, "paynspray_lae", "sf_spray_floor2", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19456,2118.2099609,-1595.0699463,1782.2449951,0.0000000,0.0000000,0.0000000); //object(wall096) (9)
	SetDynamicObjectMaterial(tmpobjid, 0, 10412, "hotel1", "carpet_red_256", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2113.4799805,-1590.3380127,1782.2449951,0.0000000,0.0000000,90.0000000); //object(wall096) (14)
	SetDynamicObjectMaterial(tmpobjid, 0, 10412, "hotel1", "carpet_red_256", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19437,2116.5280762,-1594.6219482,1783.9000244,0.0000000,90.0000000,0.0000000); //object(wall077) (6)
	SetDynamicObjectMaterial(tmpobjid, 0, 5532, "paynspray_lae", "sf_spray_floor2", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19437,2113.0300293,-1594.6219482,1783.9000244,0.0000000,90.0000000,0.0000000); //object(wall077) (7)
	SetDynamicObjectMaterial(tmpobjid, 0, 5532, "paynspray_lae", "sf_spray_floor2", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19437,2113.0300293,-1592.3850098,1783.9000244,0.0000000,90.0000000,0.0000000); //object(wall077) (8)
	SetDynamicObjectMaterial(tmpobjid, 0, 5532, "paynspray_lae", "sf_spray_floor2", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19437,2109.5300293,-1594.6219482,1783.9000244,0.0000000,90.0000000,0.0000000); //object(wall077) (9)
	SetDynamicObjectMaterial(tmpobjid, 0, 5532, "paynspray_lae", "sf_spray_floor2", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19437,2109.5300293,-1592.3850098,1783.9000244,0.0000000,90.0000000,0.0000000); //object(wall077) (10)
	SetDynamicObjectMaterial(tmpobjid, 0, 5532, "paynspray_lae", "sf_spray_floor2", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19456,2113.3310547,-1598.3349609,1783.9000244,0.0000000,90.0000000,90.0000000); //object(wall096) (8)
	SetDynamicObjectMaterial(tmpobjid, 0, 10412, "hotel1", "carpet_red_256", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19456,2113.4799805,-1592.0000000,1787.5250244,0.0000000,90.0000000,90.0000000); //object(wall096) (8)
	SetDynamicObjectMaterial(tmpobjid, 0, 10412, "hotel1", "carpet_red_256", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19456,2113.4799805,-1595.4799805,1787.5250244,0.0000000,90.0000000,90.0000000); //object(wall096) (8)
	SetDynamicObjectMaterial(tmpobjid, 0, 10412, "hotel1", "carpet_red_256", 0xFFFFFFFF);

	CreateDynamicObject(1810,2114.6630859,-1588.2900391,1783.8199463,0.0000000,0.0000000,135.0000305); //object(cj_foldchair) (1)
	CreateDynamicObject(2010,2148.8999023,-1579.1999512,1783.8000488,0.0000000,0.0000000,0.0000000); //object(nu_plant3_ofc) (2)

	//CreateDynamicObject(1420,2115.8000488,-1598.0999756,1786.0000000,0.0000000,90.0000000,90.0000000); //object(dyn_aircon) (1)
	//CreateDynamicObject(1420,2111.0000000,-1598.0999756,1786.0000000,0.0000000,90.0000000,90.0000000); //object(dyn_aircon) (2)

	tmpobjid = CreateDynamicObject(1744,2109.8969727,-1590.2800293,1784.5300293,0.0000000,0.0000000,0.0000000); //object(med_shelf) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 12954, "sw_furniture", "CJ_WOOD5", 0xFFFFFFFF);

	CreateDynamicObject(2749,2109.5839844,-1590.6340332,1784.8709717,0.0000000,0.0000000,0.0000000); //object(cj_hairspray) (1)
	CreateDynamicObject(2752,2109.7910156,-1590.6169434,1784.8709717,0.0000000,0.0000000,0.0000000); //object(cj_hairspray2) (1)
	CreateDynamicObject(2749,2109.6818848,-1590.5410156,1784.8709717,0.0000000,0.0000000,0.0000000); //object(cj_hairspray) (2)
	CreateDynamicObject(19622,2117.4519043,-1597.2049561,1784.6970215,0.0000000,0.0000000,0.0000000); //object(broom1) (1)

	tmpobjid = CreateDynamicObject(17951,2118.1550293,-1593.5200195,1785.6800537,0.0000000,0.0000000,0.0000000); //object(cjgaragedoor) (2)
	SetDynamicObjectMaterial(tmpobjid, 0, 5722, "sunrise01_lawn", "plainglass", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(19458,2108.5900879,-1595.1500244,1785.6999512,0.0000000,0.0000000,0.0000000); //object(wall098) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 10412, "hotel1", "carpet_red_256", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(14720,2137.8999023,-1578.8900146,1783.8199463,0.0000000,0.0000000,270.0000000); //object(int2lasmone02) (1)
    SetDynamicObjectMaterial(tmpobjid, 0, 11145, "carrierint_sfs", "ws_shipmetal4", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 11145, "carrierint_sfs", "ws_shipmetal4", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 2, 12954, "sw_furniture", "CJ_WOOD5", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 3, 12954, "sw_furniture", "CJ_WOOD5", 0xFFFFFFFF);

	tmpobjid = CreateDynamicObject(1432,2139.7500000,-1581.4000244,1783.8199463,0.0000000,0.0000000,90.0000000); //object(dyn_table_2) (1)
	SetDynamicObjectMaterial(tmpobjid, 0, 12954, "sw_furniture", "CJ_WOOD5", 0xFFFFFFFF);

	CreateDynamicObject(14532,2139.9799805,-1584.8139648,1784.8029785,0.0000000,0.0000000,35.0000000); //object(tv_stand_driv) (1)

	tmpobjid = CreateDynamicObject(19650,2149.0000000,-1584.9169922,1787.5000000,0.0000000,0.0000000,0.0000000); //object(tubeflat25x25m1) (1)
    SetDynamicObjectMaterial(tmpobjid, 0, 8395, "pyramid", "white", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19650,2123.8999023,-1584.9199219,1791.0400391,0.0000000,0.0000000,0.0000000); //object(tubeflat25x25m1) (1)
    SetDynamicObjectMaterial(tmpobjid, 0, 8395, "pyramid", "white", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19650,2098.8999023,-1584.9199219,1791.0400391,0.0000000,0.0000000,0.0000000); //object(tubeflat25x25m1) (1)
    SetDynamicObjectMaterial(tmpobjid, 0, 8395, "pyramid", "white", 0xFFFFFFFF);
}