function [probabilityOfSwitchedWin, probabilityOfOriginalWin] = MonteCarloIntroduction(NumTrials)
%Initialize number of trials and doors
NumDoors = 3;

%Randomly pick doors to be the winning door and player's choice

%use randi function to return arrays of size 1 * NumTrials of
%psuedorandom integers from 1 to NumDoors to mimic the winning
%doors and player's chosen door for the alloted number of trials
WinningDoor = randi(NumDoors, 1, NumTrials);
PlayersOriginalChoice = randi(NumDoors, 1, NumTrials);

%Create an array of zeros to hold boolean values to represent if the
%players original choice or the last door was the winning door
OriginalChoiceWin = zeros(1, NumTrials);
SwitchedChoiceWin = zeros(1, NumTrials);

%Update OriginalChoiceWin based on data and simulate which door 
% Monty Hall will pick
for i = 1:NumTrials

    if(PlayersOriginalChoice(i) == WinningDoor(i))
        OriginalChoiceWin(i) = 1;
    end
    
    %create a variable to show which doors are available to choose
    %remove the players door so the host cannot open them
    DoorsLeft = 1:NumDoors;
    DoorsLeft = DoorsLeft(DoorsLeft ~= PlayersOriginalChoice(i));
    
    if(OriginalChoiceWin(i))
        %choose a random remaining door for the host to open if 
        %PlayersOriginalChoice is the Winning Door
        DoorIndex = randi(2);
        HostDoor = DoorsLeft(DoorIndex);
    else
        %remove the winning door and have the host pick the last door left
        HostDoor = DoorsLeft(DoorsLeft ~= WinningDoor(i));
    end
    
    %Now simulate the player's decision at the last step
    %Case 1: They switch doors - fill the switched door array with the
    %last door option for NumTrials
    DoorsLeft = 1: NumDoors;
    %remove the original choice and the host's choice
    DoorsLeft = DoorsLeft(DoorsLeft ~= PlayersOriginalChoice(i));
    SwitchDoor = DoorsLeft(DoorsLeft ~= HostDoor);
    if (SwitchDoor == WinningDoor(i))
        SwitchedChoiceWin(i) = 1;
    end
end

%create variables to represent probabilities for each expected value
probabilityOfSwitchedWin = sum(SwitchedChoiceWin)./NumTrials;
probabilityOfOriginalWin = sum(OriginalChoiceWin)./NumTrials;

probabilityOfSwitchedWinGraph = cumsum(SwitchedChoiceWin)./(1:NumTrials);
probabilityOfOriginalWinGraph = cumsum(OriginalChoiceWin)./(1:NumTrials);

plot(1:NumTrials,probabilityOfSwitchedWinGraph,'r')
hold on
plot(1:NumTrials,probabilityOfOriginalWinGraph) 
legend('(i) Probability of Winning by Switching','(ii) Probability of Winning by NOT Switching')
xlabel('N')
ylabel('Probability of Winning')
grid on
title('Probability of Winning Lets Make A Deal vs Number of Trials')
end
    
            
    
    
    


