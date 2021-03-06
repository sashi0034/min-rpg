#pragma once
#include "stdafx.h"

#include <iostream>
#include <string.h>
#include <map>
#include <vector>




#include "lua_manager.h"
#include "ingame_manager.h"

namespace ingame
{
    static const double FPS60_MILLI = 1000.0 / 60;
    static const double FPS60_SEC = 1.0 / 60;

    enum class ZIndex
    {
        FLOOR = 1000,
        CHARACTER = 0,
        CLOUD = -1000,
        UI = -2000,
        CURTAIN = -3000,
    };


    class ButtonInTimer
    {
        std::map<int, int> mButtonTime{};
        bool notKeyOrAppend(int keyCode);
    public:
        ButtonInTimer();
        bool CheckJustAfterPress(int keyCode);
        bool ChackIntervalPress(int keyCode, int firstTime, int intervalTime);
        void Loop();
    };

    class EventTimerAsActor : public Actor
    {
        EventTimer mEventTImer;
        std::function<bool()> mDoEvent;
    protected:
        void update() override;
    public:
        EventTimerAsActor(std::function<bool()> doEvent, int intervalTime);
        EventTimer* GetEventTimer();
    };

    //class ButtonEmbeddedTimer
    //{
    //    EventTimer eventTimer{};
    //    ButtonInTimer buttonInTimer{};
    //public:
    //    ButtonEmbeddedTimer();
    //    ButtonEmbeddedTimer(std::function<bool()> doEvent, int intervalMilliSec);
    //    ButtonInTimer* GetButton();
    //    void Update();
    //};

    class SoundManager : public Actor, public ISingleton<SoundManager>
    {
        const bool isModifyVolume = false;
        const double modifyVolumeRate = 0.2;
        std::unordered_set<Sound*> modifiedVolumeSounds = {};

        std::unordered_set<Sound*> mSoundBuffer{};
        std::map<std::string, std::unique_ptr<Sound>> mDynamicSoundFile{};
    public:
        SoundManager();
        ~SoundManager();
        void Play(Sound* sound);
        void DynamicPlay(std::string filename);
    protected:
        void update() override;
    };



    class ILuaUser
    {
    protected:
        std::string mLuaClassName = "";
        sol::table mLuaData{};
        virtual void luaConstructor() = 0;
        virtual void luaUpdate() = 0;
    };

    class LuaActor : public Actor, public ILuaUser
    {
    protected:
        LuaActor(std::string luaClass, bool canLuaConstruct);
        void update() override;
        void luaConstructor() override;
        virtual void luaUpdate() override;
    };

    class LuaCollideActor : public CollideActor, public ILuaUser
    {
    protected:
        LuaCollideActor(std::string luaClass, bool canLuaConstruct, collider::Shape* col, UINT mask);
        void update() override;
        void luaConstructor() override;
        virtual void luaUpdate() override;
    };

    namespace main 
    {
        enum class EAngle
        {
            NONE = -1,
            RIGHT = 0,
            DOWN = 1,
            LEFT = 2,
            UP = 3
        };

        class NPCBase : public LuaCollideActor, public INonPlayerCharacter
        {
            int sprOriginX, sprOriginY;
        protected:
            static const int moveUnit = 8;
            double mX, mY;
            double mTempGotoX = 0, mTempGotoY = 0;
            bool mHasTempGoto = false;
            double mVel = 0;
            double mAnimTime = 0;
            EAngle mAngle = EAngle::DOWN;
            bool mIsMovingNow = false;
            int mMovingTime = 0;
            int mStopMovingTime = 0;
            bool mIsDeath = false;
        public:
            NPCBase(double startX, double startY, ECharacterKind characterKind, std::string uniqueName, int sprOriginX, int sprOriginY);
            double GetX();
            double GetY();
        protected:
            virtual void update() override;
            virtual void animation() = 0;
            virtual void driveTalkEvent();
            virtual void fadeAndDie();
            bool canMove(double toX, double toY);
            bool canMove(double toX, double toY, EAngle *getAng);
            bool doMove(double x, double y);
            bool doMoveTemporary(double x, double y);
        };

        class FieldDecorationBase : public Actor
        {
        protected:
            int mAnimTime{};
        public:
            FieldDecorationBase(int x, int y);
        protected:
            void update() override;
        };
    }
};

