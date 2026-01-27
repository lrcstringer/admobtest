export const FAKE_API = {
  getHomeSummary: () => {
    return Promise.resolve({
      greeting: "Hi, Fundeka",
      streak: 5,
      rank: 127,
      wallet: {
        zar: 34.50,
        tokens: 3450
      },
      pots: {
        daily: {
          name: "Today's pot",
          total: 5000,
          currency: "ZAR",
          closesIn: "05h 23m",
          userRank: 127,
          userScore: 450
        },
        weekly: {
          name: "This week's pot",
          total: 25000,
          currency: "ZAR",
          closesIn: "2d 14h"
        }
      }
    });
  },

  getHowItWorks: () => {
    // This content should be remote-configurable in the future
    return Promise.resolve({
      sections: [
        {
          title: "Ad + Survey Model",
          points: [
            "80% of surveys pay 5 tokens.",
            "20% of surveys pay 10 tokens (every 5th survey is a bonus)."
          ]
        },
        {
          title: "Streak Boosts",
          points: [
            "Streak boosts apply to your score only, not to tokens."
          ]
        },
        {
          title: "Reward Split",
          points: [
            "Each survey’s value is split 90/5/5 between:",
            "• Your wallet (90%)",
            "• The daily pot (5%)",
            "• The weekly pot (5%)"
          ]
        },
        {
          title: "Daily Cap",
          points: [
            "You can earn from up to 30 ads per day."
          ]
        }
      ]
    });
  }
};
