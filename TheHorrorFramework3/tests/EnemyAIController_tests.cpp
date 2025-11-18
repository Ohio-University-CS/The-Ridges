#include <gtest/gtest.h>

class EnemyAIControllerLogic
{
public:
    bool hasBlackboardAsset;
    bool hasBehaviorTreeAsset;
    bool useBlackboardReturn;
    bool playerPawnExists;

    bool useBlackboardCalled;
    bool runBehaviorTreeCalled;
    bool playerTargetSet;
    bool blackboardInitialized;

    EnemyAIControllerLogic()
        : hasBlackboardAsset(true),
          hasBehaviorTreeAsset(true),
          useBlackboardReturn(true),
          playerPawnExists(true),
          useBlackboardCalled(false),
          runBehaviorTreeCalled(false),
          playerTargetSet(false),
          blackboardInitialized(false)
    {
    }

    void BeginPlay()
    {
        useBlackboardCalled = false;
        runBehaviorTreeCalled = false;
        playerTargetSet = false;
        blackboardInitialized = false;

        if (!hasBlackboardAsset)
            return;

        useBlackboardCalled = true;
        blackboardInitialized = useBlackboardReturn;

        if (!useBlackboardReturn)
            return;

        if (hasBehaviorTreeAsset)
            runBehaviorTreeCalled = true;

        if (playerPawnExists && blackboardInitialized)
            playerTargetSet = true;
    }
};

TEST(EnemyAIControllerLogicTests, BlackboardAssetGate)
{
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = true;
        ai.BeginPlay();
        EXPECT_TRUE(ai.useBlackboardCalled);
    }
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.useBlackboardCalled);
    }
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.runBehaviorTreeCalled);
    }
}

TEST(EnemyAIControllerLogicTests, UseBlackboardCalledWhenAssetPresent)
{
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = true;
        ai.BeginPlay();
        EXPECT_TRUE(ai.useBlackboardCalled);
    }
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = true;
        ai.useBlackboardReturn = false;
        ai.BeginPlay();
        EXPECT_TRUE(ai.useBlackboardCalled);
    }
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.useBlackboardCalled);
    }
}

TEST(EnemyAIControllerLogicTests, UseBlackboardFailurePreventsProgress)
{
    {
        EnemyAIControllerLogic ai;
        ai.useBlackboardReturn = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.runBehaviorTreeCalled);
    }
    {
        EnemyAIControllerLogic ai;
        ai.useBlackboardReturn = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.playerTargetSet);
    }
    {
        EnemyAIControllerLogic ai;
        ai.useBlackboardReturn = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.blackboardInitialized == false ? false : true);
    }
}

TEST(EnemyAIControllerLogicTests, BehaviorTreeRunsWhenAvailable)
{
    {
        EnemyAIControllerLogic ai;
        ai.BeginPlay();
        EXPECT_TRUE(ai.runBehaviorTreeCalled);
    }
    {
        EnemyAIControllerLogic ai;
        ai.hasBehaviorTreeAsset = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.runBehaviorTreeCalled);
    }
    {
        EnemyAIControllerLogic ai;
        ai.useBlackboardReturn = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.runBehaviorTreeCalled);
    }
}

TEST(EnemyAIControllerLogicTests, BehaviorTreeDependsOnBlackboardAndAsset)
{
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = true;
        ai.hasBehaviorTreeAsset = true;
        ai.useBlackboardReturn = true;
        ai.BeginPlay();
        EXPECT_TRUE(ai.runBehaviorTreeCalled);
    }
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = true;
        ai.hasBehaviorTreeAsset = false;
        ai.useBlackboardReturn = true;
        ai.BeginPlay();
        EXPECT_FALSE(ai.runBehaviorTreeCalled);
    }
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = true;
        ai.hasBehaviorTreeAsset = true;
        ai.useBlackboardReturn = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.runBehaviorTreeCalled);
    }
}

TEST(EnemyAIControllerLogicTests, PlayerTargetSetWhenConditionsMet)
{
    {
        EnemyAIControllerLogic ai;
        ai.BeginPlay();
        EXPECT_TRUE(ai.playerTargetSet);
    }
    {
        EnemyAIControllerLogic ai;
        ai.playerPawnExists = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.playerTargetSet);
    }
    {
        EnemyAIControllerLogic ai;
        ai.useBlackboardReturn = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.playerTargetSet);
    }
}

TEST(EnemyAIControllerLogicTests, PlayerTargetDependsOnBlackboard)
{
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = true;
        ai.useBlackboardReturn = true;
        ai.BeginPlay();
        EXPECT_TRUE(ai.playerTargetSet);
    }
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.playerTargetSet);
    }
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = true;
        ai.useBlackboardReturn = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.playerTargetSet);
    }
}

TEST(EnemyAIControllerLogicTests, CombinedSuccessPath)
{
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = true;
        ai.hasBehaviorTreeAsset = true;
        ai.useBlackboardReturn = true;
        ai.playerPawnExists = true;
        ai.BeginPlay();
        EXPECT_TRUE(ai.useBlackboardCalled);
        EXPECT_TRUE(ai.runBehaviorTreeCalled);
        EXPECT_TRUE(ai.playerTargetSet);
    }
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = true;
        ai.hasBehaviorTreeAsset = true;
        ai.useBlackboardReturn = true;
        ai.playerPawnExists = false;
        ai.BeginPlay();
        EXPECT_TRUE(ai.useBlackboardCalled);
        EXPECT_TRUE(ai.runBehaviorTreeCalled);
        EXPECT_FALSE(ai.playerTargetSet);
    }
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = true;
        ai.hasBehaviorTreeAsset = false;
        ai.useBlackboardReturn = true;
        ai.playerPawnExists = true;
        ai.BeginPlay();
        EXPECT_TRUE(ai.useBlackboardCalled);
        EXPECT_FALSE(ai.runBehaviorTreeCalled);
        EXPECT_TRUE(ai.playerTargetSet);
    }
}

TEST(EnemyAIControllerLogicTests, CombinedFailureBlackboardMissing)
{
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = false;
        ai.BeginPlay();
        EXPECT_FALSE(ai.useBlackboardCalled);
        EXPECT_FALSE(ai.runBehaviorTreeCalled);
        EXPECT_FALSE(ai.playerTargetSet);
    }
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = false;
        ai.playerPawnExists = true;
        ai.BeginPlay();
        EXPECT_FALSE(ai.useBlackboardCalled);
        EXPECT_FALSE(ai.playerTargetSet);
    }
    {
        EnemyAIControllerLogic ai;
        ai.hasBlackboardAsset = false;
        ai.hasBehaviorTreeAsset = true;
        ai.BeginPlay();
        EXPECT_FALSE(ai.runBehaviorTreeCalled);
    }
}

TEST(EnemyAIControllerLogicTests, CombinedFailureUseBlackboardFalse)
{
    {
        EnemyAIControllerLogic ai;
        ai.useBlackboardReturn = false;
        ai.BeginPlay();
        EXPECT_TRUE(ai.useBlackboardCalled);
        EXPECT_FALSE(ai.runBehaviorTreeCalled);
        EXPECT_FALSE(ai.playerTargetSet);
    }
    {
        EnemyAIControllerLogic ai;
        ai.useBlackboardReturn = false;
        ai.playerPawnExists = true;
        ai.BeginPlay();
        EXPECT_FALSE(ai.playerTargetSet);
    }
    {
        EnemyAIControllerLogic ai;
        ai.useBlackboardReturn = false;
        ai.hasBehaviorTreeAsset = true;
        ai.BeginPlay();
        EXPECT_FALSE(ai.runBehaviorTreeCalled);
    }
}
