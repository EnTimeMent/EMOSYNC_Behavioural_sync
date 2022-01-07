% MG_SimSpace_ : similarities between ???

% Velocity profile
clear all; clc; close all;

order = 4; cutOff = 10; SampleFreq = 100;
[param1, param2] = butter(order,(cutOff/(SampleFreq/2)));
kk=1;
deb=100;
fin=2980;
%

for p=1 %Numero de la dyade
    
    %Condition/Session 1, Emotions SOLO
    for c=1
        for j=1:9 %Essais solo de P1 NEUTRE
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial0' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq); %fin-diff est une fonction qui dérive un signal, ici un signal de position
            
            kk=kk+1
        end
        
        for j=10:18 %Essais solo de P2 NEUTRE
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=19:27 %Essais solo de P1 EMOTION 1
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,1);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        for j=28:36 %Essais solo de P2 EMOTION 1
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt(param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        for j=37:45 %Essais solo de P1 EMOTION 2
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt(param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        for j=46:54 %Essais solo de P2 EMOTION 2
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt(param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
    end
    
    %Condition 2, DUO émotions congruentes
    for c = 2
        
        for j=1:9 %Essais duo de P1 NEUTRE
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial0' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=1:9 %Essais duo de P2 NEUTRE
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial0' num2str(j)])
            out_marker=out_marker.sujet2;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=10:18 %Essais duo de P1 EMOTION 1
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=10:18 %Essais duo de P2 EMOTION 1
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet2;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=19:27 %Essais duo de P1 EMOTION 2
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=19:27 %Essais duo de P2 EMOTION 2
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet2;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
    end
    
    %Condition 3, DUO Emotions non congruentes
    for c=3
        
        for j=1:9 %Essais duo de P1 EMOTION A
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial0' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=1:9 %Essais duo de P2 NEUTRE
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial0' num2str(j)])
            out_marker=out_marker.sujet2;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=10:18 %Essais duo de P1 NEUTRE
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        for j=10:18 %Essais duo de P2 EMOTION A
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet2;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=19:27 %Essais solo de P1 EMOTION B
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,1);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=19:27 %Essais solo de P2  NEUTRE
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet2;
            data= out_marker(deb:fin,1);
            data_filt = filtfilt( param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=28:36 %Essais solo de P1  NEUTRE
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt(param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        for j=28:36 %Essais solo de P2 EMOTION B
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Pre_test\condition_' num2str(c) '/condition 3' num2str(j)])
            out_marker=out_marker.sujet2;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt(param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=37:45 %Essais solo de P1 EMOTION B
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt(param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=37:45 %Essais solo de P2 EMOTION A
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet2;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt(param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=46:54 %Essais solo de P1 EMOTION A
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet1;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt(param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
        for j=46:54 %Essais solo de P2 EMOTION B
            load(['C:\Users\Juliette\Desktop\M2_Stage\DuoMotion\Resultats\Dyade_' num2str(p) '/Session ' num2str(c) '/Trial' num2str(j)])
            out_marker=out_marker.sujet2;
            data= out_marker(deb:fin,2);
            data_filt = filtfilt(param1, param2, data);
            data_for_histograms(kk).vec= fin_diff(data_filt,1/SampleFreq);
            kk=kk+1
        end
        
    end
end
% I. On a calculé les vitesses pour tous les trials ...

for i=1:kk-1
    min_mrk2(i)=min(data_for_histograms(i).vec); %Take the min of signal in data_for-histograms for each trial
    max_mrk2(i)=max(data_for_histograms(i).vec);
end

% % COMPUTE BINS
m_max=3.5; m_min=-3.5; %-3.5

bins=linspace(m_min,m_max,101); %create a vector of 101 cells which start from -3,5 to 3,5, filled linearly
bin_width=bins(2)-bins(1); % widths (=largeur) of the bins
max_emd=m_max-m_min; % maximal EMD (Earth's movers distance) - dist between 2 PDF

% % % COMPUTE ELEMENTS OF MATRIX - I.E. DISTANCES
numb_of_all_hist=numel(data_for_histograms); % Number of all columns.
emds=zeros(numb_of_all_hist); %create a matrix of zeros which has a size of numb_of_all_hist*numb_of_all_hist

for id1=1:numb_of_all_hist
    for id2=id1:numb_of_all_hist
        
        h1=hist(data_for_histograms(id1).vec,bins); %create histogram of 101 columns for each trial
        h2=hist(data_for_histograms(id2).vec,bins);
        l1=numel(data_for_histograms(id1).vec); % = sum(h1)for normalisation
        l2=numel(data_for_histograms(id2).vec);
        
        % Integral of abs(CDF1 - CDF2)
        emds(id1,id2)=sum(abs(cumsum(h1/l1)-cumsum(h2/l2)))*bin_width/max_emd;
    end
end

emds=emds+triu(emds)'; %"triu" > returns the upper triangular portion of matrix emds

[xx,ev]=cmdscale(emds); %Compute the multidimentional scaling of the matrix emds

% Compute every distance

ctr=1;
for i=1:216:kk-1
    
    idx1 = i:(i+8)          %P1 solo neutre     (c=1)
    idx2 =(i+9):(i+17)      %P2 solo neutre     (c=1)
    idx3 =(i+18):(i+26)     %P1 solo emotion A  (c=1)
    idx4 =(i+27):(i+35)     %P2 solo emotion A  (c=1)
    idx5 =(i+36):(i+44)     %P1 solo emotion B  (c=1)
    idx6 =(i+45):(i+53)     %P2 solo emotion B  (c=1)
    
    idx7 =(i+54):(i+62)     %P1 duo neutre      (c=2)
    idx8 =(i+63):(i+71)     %P2 duo neutre      (c=2)
    idx9 =(i+72):(i+80)     %P1 duo emotion A   (c=2)
    idx10=(i+81):(i+89)     %P2 duo emotion A   (c=2)
    idx11=(i+90):(i+98)     %P1 duo emotion B   (c=2)
    idx12=(i+99):(i+107)    %P2 duo emotion B   (c=2)
    
    idx13=(i+108):(i+116)   %P1 duo emotion A   (c=3)
    idx14=(i+117):(i+125)   %P2 duo emotion N   (c=3)
    idx15=(i+126):(i+134)   %P1 duo emotion N   (c=3)
    idx16=(i+135):(i+143)   %P2 duo emotion A   (c=3)
    idx17=(i+144):(i+152)   %P1 duo emotion B   (c=3)
    idx18=(i+153):(i+161)   %P2 duo emotion N   (c=3)
    idx19=(i+162):(i+170)   %P1 duo emotion N   (c=3)
    idx20=(i+171):(i+179)   %P2 duo emotion B   (c=3)
    idx21=(i+180):(i+188)   %P1 duo emotion B   (c=3)
    idx22=(i+189):(i+197)   %P2 duo emotion A   (c=3)
    idx23=(i+198):(i+206)   %P1 duo emotion A   (c=3)
    idx24=(i+207):(i+215)   %P2 duo emotion B   (c=3)
    
    %distance for P1 or P2 between neutral and emotion A and B
    
    %Neutral - Emotion A
    emd_P1_neutral_emoA(ctr)= mean(mean(emds(idx1,idx3)));
    emd_P2_neutral_emoA(ctr)= mean(mean(emds(idx2,idx4)));
    %Neutral - Emotion B
    emd_P1_neutral_emoB(ctr)= mean(mean(emds(idx1,idx5)));
    emd_P2_neutral_emoB(ctr)= mean(mean(emds(idx2,idx6)));
    
    %distance between P1 & P2 before (emd_P1_P2) and during the interaction(emd_NI_P1_P2) for neutral and emotion A and B
    
    %Neutre
    emd_P1_P2_neutral(ctr)= mean(mean(emds(idx1,idx2)));
    emd_NI_P1_P2_neutral(ctr)= mean(mean(emds(idx7,idx8)));
    %Emotion 1
    emd_P1_P2_emoA(ctr)= mean(mean(emds(idx3,idx4)));
    emd_NI_P1_P2_emoA(ctr)= mean(mean(emds(idx9,idx10)));
    %Emotion 2
    emd_P1_P2_emoB(ctr)= mean(mean(emds(idx5,idx6)));
    emd_NI_P1_P2_emoB(ctr)= mean(mean(emds(idx11,idx12)));
    
    %distance between P1 & P2 when emotions aren't congruent
    
    emd1_P1_emoA_P2_emoN(ctr)= mean(mean(emds(idx13,idx14)));
    emd2_P1_emoN_P2_emoA(ctr)= mean(mean(emds(idx15,idx16)));
    emd3_P1_emoB_P2_emoN(ctr)= mean(mean(emds(idx17,idx18)));
    emd4_P1_emoN_P2_emoB(ctr)= mean(mean(emds(idx19,idx20)));
    emd5_P1_emoA_P2_emoB(ctr)= mean(mean(emds(idx21,idx22)));
    emd6_P1_emoB_P2_emoA(ctr)= mean(mean(emds(idx23,idx24)));
    
    %TOTAL    
    %TOTAL distance for P1 or P2 between neutral and emotion 1 and 2
    emdTOT_solo_P1_P2 = [emd_P1_neutral_emoA(ctr),emd_P2_neutral_emoA(ctr),emd_P1_neutral_emoB(ctr),emd_P2_neutral_emoB(ctr)]
    %TOTAL distance between P1 & P2 before and during the interaction for neutral and emotion 1 and 2
    emdTOT_solo_duo_P1_P2 = [emd_P1_P2_neutral(ctr),emd_NI_P1_P2_neutral(ctr),emd_P1_P2_emoA(ctr),emd_NI_P1_P2_emoA(ctr),emd_P1_P2_emoB(ctr),emd_NI_P1_P2_emoB(ctr)]
    %TOTAL distance between P1 & P2 when emotions aren't congruent
    emdTOT_duo_P1_P2_emoAB = [emd1_P1_emoA_P2_emoN(ctr),emd2_P1_emoN_P2_emoA(ctr),emd3_P1_emoB_P2_emoN(ctr),emd4_P1_emoN_P2_emoB(ctr),emd5_P1_emoA_P2_emoB(ctr),emd6_P1_emoB_P2_emoA(ctr)]
    
    ctr=ctr+1
    
end

% Compute distances for emotional contagion

ctr=1;
for i=1:216:kk-1
    
    emd_P1_solo_duo_neutral(ctr)= mean(mean(emds(idx1,idx7)))        %distance between solo neutral and duo neutral (congruent) for P1
    emd_P1_duo_duo_neutralVSemoA(ctr)= mean(mean(emds(idx7,idx15)))  %distance between duo neutral (congurent) et duo neutral non congruent (vs emotion A) for P1
    emd_P1_solo_duo_neutralVSemoA(ctr)= mean(mean(emds(idx1,idx15))) %distance between solo neutral et duo neutral non congruent (vs emotion A) for P1
    emd_P1_duo_duo_neutralVSemoB(ctr)= mean(mean(emds(idx7,idx19)))  %distance between duo neutral (congurent) et duo neutral non congruent (vs emotion B) for P1
    emd_P1_solo_duo_neutralVSemoB(ctr)= mean(mean(emds(idx1,idx19))) %distance between solo neutral et duo neutral non congruent (vs emotion B) for P1
    
    emd_P2_solo_duo_neutral(ctr)= mean(mean(emds(idx2,idx8)))        %distance between solo neutral and duo neutral (congruent) for P2
    emd_P2_duo_duo_neutralVSemoA(ctr)= mean(mean(emds(idx8,idx14)))  %distance between duo neutral (congurent) et duo neutral non congruent (vs emotion A) for P2
    emd_P2_solo_duo_neutralVSemoA(ctr)= mean(mean(emds(idx2,idx14))) %distance between solo neutral et duo neutral non congruent (vs emotion A) for P2
    emd_P2_duo_duo_neutralVSemoB(ctr)= mean(mean(emds(idx8,idx18)))  %distance between duo neutral (congurent) et duo neutral non congruent (vs emotion B) for P2
    emd_P2_solo_duo_neutralVSemoB(ctr)= mean(mean(emds(idx2,idx18))) %distance between solo neutral et duo neutral non congruent (vs emotion B) for P2
    
    
    %TOTAL
    emdTOT_P1_emo_contagion = [emd_P1_solo_duo_neutral(ctr),emd_P1_duo_duo_neutralVSemoA(ctr),emd_P1_solo_duo_neutralVSemoA(ctr),emd_P1_duo_duo_neutralVSemoB(ctr),emd_P1_solo_duo_neutralVSemoB(ctr)]
    emdTOT_P2_emo_contagion = [emd_P2_solo_duo_neutral(ctr),emd_P2_duo_duo_neutralVSemoA(ctr),emd_P2_solo_duo_neutralVSemoA(ctr),emd_P2_duo_duo_neutralVSemoB(ctr),emd_P2_solo_duo_neutralVSemoB(ctr)]
    
end
%
colors=lines(3500);
colors=colors(1:10:end,:);
k=1;
for i=1:9:kk-1
    idx=i:i+8;
    
    % Plot similarity space with ellipses
    figure (1)
    plot(xx(idx,1),xx(idx,2),'.','MarkerSize',8,'color',colors(k,:));
    hold on
    text(mean(xx(idx,1)),mean(xx(idx,2)),num2str(k),'FontSize',12,'FontWeight','bold','color',colors(k,:))
    plotgauss2d([mean(xx(idx,1)) mean(xx(idx,2))]',cov(xx(idx,1),xx(idx,2)),'conf',0.7,'Color',colors(k,:),'LineWidth',1.1);
    k=k+1;
end



