#pragma once

#include <iostream>
#include <string.h>
#include <map>
#include <vector>

#include "magic_enum.h"

#include "game_utils.h"
#include "game_engine.h"
#include "lua_manager.h"


using namespace gameUtils;
using namespace gameEngine;

namespace ingame
{
	template <typename T>
	class Singleton
	{
	public:
		Singleton()
		{
			if (Sole != nullptr)
			{
				std::cerr ERR_LOG "Singleton object is already exit\n";
				return;
			}
			Sole = static_cast<T*>(this);
		}
		~Singleton()
		{
			Sole = nullptr;
		}
		static T* Sole;
	};
	template <typename T> T* Singleton<T>::Sole = nullptr;


	enum class ETileName
	{
		none,
		water_place,
		sand_pit,
		meadows,
		grass,
		tree,
		house,
		weed
	};

	struct TileMapChip
	{
		ETileName Name;
		bool IsWall;
		int srcX;
		int srcY;
	};


	struct MapMatElement
	{
		std::vector<TileMapChip*> Chips{};
		std::vector<byte> HasChip{}; // std::vector<bool>は遅いらしいのでbyteで管理
		bool IsWall = false;

		void Update();
		~MapMatElement();
	};

	class MapManager : public Singleton<MapManager>
	{
	private:
		Graph* mTilesetGraph;
		std::map<int, TileMapChip*> mTilechips{};
		
		int mWidth;
		int mHeight;
		std::vector<std::vector<MapMatElement*>> mMat{};
		bool doStartChip(int x, int y, ETileName tile);
		
	public:
		MapManager(int stageIndex);
		~MapManager();
		int GetWidth();
		int GetHeight();
		bool IsInRange(int x, int y);
		MapMatElement* GetMatAt(int x, int y);
		Graph* GetTilesetGraph();
	};




	class BackGroundManager : public SelfDrawingActor
	{
	public:
		BackGroundManager();
	protected:
		void update() override;
		void drawing(int hX, int hY) override;
	};



	/// <summary>
	/// TileMapレイヤー描画の基底クラス
	/// drawingChipを実装する必要がある
	/// </summary>
	class FieldLayerBase : public SelfDrawingActor
	{
	protected:
		int mGridUnit = 16;
		double mZ;
	public:
		FieldLayerBase(double z);
	protected:
		void drawing(int hX, int hY) override;
		/// <summary>
		/// 個々のマップチップの描画
		/// </summary>
		/// <param name="matX">Matrix X</param>
		/// <param name="matY">Matrix Y</param>
		/// <param name="dpX">Display X</param>
		/// <param name="dpY">Display Y</param>
		virtual void drawingChip(int matX, int matY, int dpX, int dpY, TileMapChip* chip) = 0;

		void drawingAutoTile(int matX, int matY, int dpX, int dpY,
			Graph* srcImage, int srcX, int srcY, std::function<bool(int x, int y)> canConnect);
		bool canConnect(int x, int y, ETileName tile);
		bool canConnect(int x, int y, ETileName tile1, ETileName tile2);
		bool canConnect(int x, int y, ETileName tile1, ETileName tile2, ETileName tile3);
		bool canConnect(int x, int y, ETileName tile1, ETileName tile2, ETileName tile3, ETileName tile4);
	};

	class FloorLayer : public FieldLayerBase
	{
	public:
		FloorLayer();
	protected:
		void drawingChip(int matX, int matY, int dpX, int dpY, TileMapChip* chip) override;
	};

}

