import { MobileFrame } from "@/components/layout/mobile-frame";
import { Button } from "@/components/ui/button";
import { ArrowLeft, Wallet, Trophy, Users, Smartphone, MessageCircle, Gift, Sparkles } from "lucide-react";
import { Link } from "wouter";

export default function HowItWorks() {
  return (
    <MobileFrame>
      <div className="flex flex-col h-full bg-background">
        <header className="px-6 py-6 sticky top-0 z-20 bg-background/95 backdrop-blur-md border-b border-white/5">
          <div className="flex items-center gap-3">
            <Link href="/home">
              <Button variant="ghost" size="icon" className="text-white hover:bg-white/10 rounded-full -ml-2">
                <ArrowLeft size={20} />
              </Button>
            </Link>
            <h1 className="text-xl font-heading font-bold text-white">How it works</h1>
          </div>
        </header>

        <div className="flex-1 overflow-y-auto">
          <div className="p-6 space-y-12 pb-24">
            {/* Intro */}
            <div className="space-y-4">
              <h2 className="text-2xl font-bold text-white leading-tight">
                iMaliChat is a money app that pays you for your attention.
              </h2>
              <p className="text-muted-foreground leading-relaxed">
                You earn tokens by watching short ads and answering tiny surveys – then you can:
              </p>
              <ul className="space-y-2">
                <li className="flex gap-3 text-sm text-white">
                  <div className="w-1.5 h-1.5 rounded-full bg-primary mt-2 shrink-0" />
                  build up a wallet balance
                </li>
                <li className="flex gap-3 text-sm text-white">
                  <div className="w-1.5 h-1.5 rounded-full bg-primary mt-2 shrink-0" />
                  climb daily and weekly leaderboards
                </li>
                <li className="flex gap-3 text-sm text-white">
                  <div className="w-1.5 h-1.5 rounded-full bg-primary mt-2 shrink-0" />
                  send and request value with friends
                </li>
                <li className="flex gap-3 text-sm text-white">
                  <div className="w-1.5 h-1.5 rounded-full bg-primary mt-2 shrink-0" />
                  spend on things like airtime
                </li>
              </ul>
              <div className="bg-secondary/10 border border-secondary/20 p-4 rounded-xl">
                 <p className="text-sm font-medium text-secondary">
                   No gambling, no guessing. Just fair rewards for time you already spend on your phone.
                 </p>
              </div>
            </div>

            {/* Section 1 */}
            <section className="space-y-4">
              <div className="flex items-center gap-3 mb-2">
                <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center text-primary font-bold border border-primary/20">1</div>
                <h3 className="text-lg font-bold text-white">Earn tokens from short ads & surveys</h3>
              </div>
              <p className="text-muted-foreground text-sm leading-relaxed">
                Most of what you do in iMaliChat happens in the Earn area. There you’ll see earn messages from different brands.
              </p>
              
              <div className="bg-card border border-white/5 rounded-xl p-4 space-y-3">
                <h4 className="text-white font-bold text-sm">How it works:</h4>
                <ol className="space-y-3">
                  <li className="flex gap-3 text-sm text-muted-foreground">
                    <span className="text-white font-bold">•</span>
                    <span>Tap an earn message to open it.</span>
                  </li>
                  <li className="flex gap-3 text-sm text-muted-foreground">
                    <span className="text-white font-bold">•</span>
                    <span>Watch/read the content (images have a countdown, videos play fully).</span>
                  </li>
                  <li className="flex gap-3 text-sm text-muted-foreground">
                    <span className="text-white font-bold">•</span>
                    <span>Answer the quick survey question(s).</span>
                  </li>
                </ol>
                <div className="pt-2 border-t border-white/5">
                   <p className="text-xs text-white">
                     Every time you complete that flow, you earn tokens. Tokens are your in-app money.
                   </p>
                </div>
              </div>
            </section>

            {/* Section 2 */}
            <section className="space-y-4">
              <div className="flex items-center gap-3 mb-2">
                <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center text-primary font-bold border border-primary/20">2</div>
                <h3 className="text-lg font-bold text-white">Scores, streaks & leaderboards</h3>
              </div>
              <p className="text-muted-foreground text-sm leading-relaxed">
                Each time you earn, two things happen:
              </p>
              <div className="grid grid-cols-1 gap-3">
                <div className="bg-card border border-white/5 rounded-xl p-3 flex gap-3 items-center">
                   <div className="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center shrink-0">
                     <Wallet size={18} className="text-primary" />
                   </div>
                   <div>
                     <p className="text-white font-bold text-sm">You get tokens</p>
                     <p className="text-xs text-muted-foreground">Guaranteed value you keep in your wallet.</p>
                   </div>
                </div>
                <div className="bg-card border border-white/5 rounded-xl p-3 flex gap-3 items-center">
                   <div className="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center shrink-0">
                     <Trophy size={18} className="text-secondary" />
                   </div>
                   <div>
                     <p className="text-white font-bold text-sm">You get score</p>
                     <p className="text-xs text-muted-foreground">Used for ranking against other users.</p>
                   </div>
                </div>
              </div>
              <p className="text-sm text-muted-foreground bg-white/5 p-3 rounded-lg border-l-2 border-secondary">
                <strong className="text-white">Pro tip:</strong> If you come back regularly, you build a streak. Streaks boost your score, helping you climb the leaderboard faster.
              </p>
            </section>

            {/* Section 3 */}
            <section className="space-y-4">
              <div className="flex items-center gap-3 mb-2">
                <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center text-primary font-bold border border-primary/20">3</div>
                <h3 className="text-lg font-bold text-white">Daily & weekly pots (bonus rewards)</h3>
              </div>
              <p className="text-muted-foreground text-sm leading-relaxed">
                On top of your normal tokens, iMaliChat has two extra bonus pots: a Daily Pot and a Weekly Pot.
              </p>
              <p className="text-muted-foreground text-sm leading-relaxed">
                A small slice of the value from each completed ad + survey goes into these pots. At the end of each period, the top users on the leaderboard share the pot.
              </p>
              <div className="bg-gradient-to-br from-secondary/10 to-orange-500/5 border border-secondary/20 rounded-xl p-4">
                <p className="text-sm font-medium text-white mb-2">In the Pots section you can see:</p>
                <ul className="space-y-1">
                  <li className="text-xs text-muted-foreground flex items-center gap-2">
                    <Sparkles size={10} className="text-secondary" /> How big the pots are
                  </li>
                  <li className="text-xs text-muted-foreground flex items-center gap-2">
                    <Sparkles size={10} className="text-secondary" /> How much time is left
                  </li>
                  <li className="text-xs text-muted-foreground flex items-center gap-2">
                    <Sparkles size={10} className="text-secondary" /> Your current rank and score
                  </li>
                </ul>
              </div>
            </section>

            {/* Section 4 */}
            <section className="space-y-4">
              <div className="flex items-center gap-3 mb-2">
                <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center text-primary font-bold border border-primary/20">4</div>
                <h3 className="text-lg font-bold text-white">Your wallet & history</h3>
              </div>
              <p className="text-muted-foreground text-sm leading-relaxed">
                All tokens you earn, win, or spend flow through your wallet. Inside the wallet you’ll see your balance and a full transaction history.
              </p>
              <p className="text-sm text-muted-foreground">
                If you ever wonder “Where did that come from?” or “Where did it go?”, the wallet history is your answer.
              </p>
            </section>

            {/* Section 5 */}
            <section className="space-y-4">
              <div className="flex items-center gap-3 mb-2">
                <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center text-primary font-bold border border-primary/20">5</div>
                <h3 className="text-lg font-bold text-white">Money Chat: move value between people</h3>
              </div>
              <p className="text-muted-foreground text-sm leading-relaxed">
                Money Chat lets you use your balance with people you trust. Send tokens to friends or request from them.
              </p>
              <div className="bg-card border border-white/5 rounded-xl p-4 flex items-center gap-4">
                 <div className="w-12 h-12 rounded-full bg-white/5 flex items-center justify-center shrink-0">
                   <MessageCircle size={24} className="text-white" />
                 </div>
                 <p className="text-xs text-muted-foreground">
                   Every send or request shows up as a chat-style entry in your Money Chat thread, so everything stays transparent.
                 </p>
              </div>
            </section>

            {/* Section 6 */}
            <section className="space-y-4">
              <div className="flex items-center gap-3 mb-2">
                <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center text-primary font-bold border border-primary/20">6</div>
                <h3 className="text-lg font-bold text-white">Invite friends & earn together</h3>
              </div>
              <p className="text-muted-foreground text-sm leading-relaxed">
                When you invite someone from inside iMaliChat, we link their phone number to your account (first-touch wins).
              </p>
              <div className="bg-gradient-to-r from-primary/10 to-purple-500/10 border border-primary/20 rounded-xl p-4 space-y-3">
                 <div className="flex items-start gap-3">
                    <Gift size={20} className="text-primary mt-1" />
                    <div>
                      <p className="text-sm font-bold text-white">Starter Bonuses</p>
                      <p className="text-xs text-muted-foreground">When they join, both you and your friend get a token bonus.</p>
                    </div>
                 </div>
                 <div className="flex items-start gap-3">
                    <Users size={20} className="text-primary mt-1" />
                    <div>
                      <p className="text-sm font-bold text-white">Assist Score</p>
                      <p className="text-xs text-muted-foreground">Over time, your assist score grows as they continue to earn.</p>
                    </div>
                 </div>
              </div>
              <p className="text-xs text-muted-foreground italic">
                The idea is to reward real, active referrals, not spammy invites.
              </p>
            </section>

            {/* Section 7 */}
            <section className="space-y-4">
              <div className="flex items-center gap-3 mb-2">
                <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center text-primary font-bold border border-primary/20">7</div>
                <h3 className="text-lg font-bold text-white">Spending your tokens</h3>
              </div>
              <p className="text-muted-foreground text-sm leading-relaxed">
                As your tokens grow, you’ll be able to use them inside the app – starting with airtime purchases. Over time, more ways to spend will be added.
              </p>
              <div className="bg-card border border-white/5 rounded-xl p-4 flex items-center gap-4">
                 <div className="w-12 h-12 rounded-full bg-white/5 flex items-center justify-center shrink-0">
                   <Smartphone size={24} className="text-white" />
                 </div>
                 <p className="text-xs text-muted-foreground">
                   Every spend shows in your wallet history so you always know how your value is being used.
                 </p>
              </div>
            </section>

          </div>
        </div>
      </div>
    </MobileFrame>
  );
}