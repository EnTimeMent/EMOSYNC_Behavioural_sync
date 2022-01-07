% MG1


% Amplitude profile (lengths of movement segments)
clear all; clc; close all;
kk=1;
t=1/120:1/120:56;
for p=26:50
    for j=1:9
        load(['/Users/star33rech/Desktop/Exp_Personality/Data/D' num2str(p) '/Trial0' num2str(j)])
        data_for_histograms(kk).vec= out_marker(240:6960,1);
        kk=kk+1
    end
    for j=10:18
        load(['/Users/star33rech/Desktop/Exp_Personality/Data/D' num2str(p) '/Trial0' num2str(j)])
        data_for_histograms(kk).vec= out_marker(240:6960,2);
        kk=kk+1
    end
    for j=19:27
        load(['/Users/star33rech/Desktop/Exp_Personality/Data/D' num2str(p) '/Trial0' num2str(j)])
        data_for_histograms(kk).vec= out_marker(240:6960,1);
        kk=kk+1
    end
    for j=19:27
        load(['/Users/star33rech/Desktop/Exp_Personality/Data/D' num2str(p) '/Trial0' num2str(j)])
        data_for_histograms(kk).vec= out_marker(240:6960,2);
        kk=kk+1
    end
end
%
m_max=2;
m_min=-2;

bins=linspace(m_min,m_max,51);
bin_width=bins(2)-bins(1); % widths of the bins
max_emd=m_max-m_min; % maximal EMD (Earth's movers distance)

% % % COMPUTE ELEMENTS OF MATRIX - I.E. DISTANCES
numb_of_all_hist=numel(data_for_histograms);
emds=zeros(numb_of_all_hist);

for id1=1:numb_of_all_hist
    for id2=id1:numb_of_all_hist
        
        p= data_for_histograms(id1).vec;
        v= fin_diff(p,1/120); % finite difference for derivative calculus
        sv=sign(v); %motion in two directions detected as a sign of velocity
        cs_idx=diff(sv); %to detect points where the direction changes check if there are jumps in sign of the velocity
        zrs=find(abs(cs_idx)==1 | abs(cs_idx)==2); %find zeros
        
        % check if the last zero is at the end of the vector
        if zrs(end)<numel(t)
            nzrs=numel(zrs);
        else
            zrs=zrs(1:end-1); %if it is at the end throw it away
            nzrs=numel(zrs);
        end
        t_zrs=zeros(1, nzrs); %allocate memory for times when direction of movement changes
        p_zrs=zeros(1, nzrs); %allocate memory for positions when the direction of movement changes
        
        for i=1:nzrs
            idx1=zrs(i);
            % interpolate for accuracy
            t_zrs(i)=interp1(v(idx1:idx1+1),t(idx1:idx1+1),0,'pchip'); % time of velocity equal to 0
            p_zrs(i)=interp1(t(idx1:idx1+1),p(idx1:idx1+1),t_zrs(i),'pchip'); % position at the time at wich velocity is equal to 0
        end
        
        h1=hist(diff(p_zrs),bins); %raw
        l1=numel(p_zrs); % for normalisation
        
        p= data_for_histograms(id2).vec;
        v= fin_diff(p,1/120);
        sv=sign(v); %motion in two directions detected as a sign of velocity
        cs_idx=diff(sv); %to detect points where the direction changes check if there are jumps in sign of the velocity
        zrs=find(abs(cs_idx)==1 | abs(cs_idx)==2); %find zeros
        
        % check if the last zero is at the end of the vector
        if zrs(end)<numel(t)
            nzrs=numel(zrs);
        else
            zrs=zrs(1:end-1); %if it is at the end throw it away
            nzrs=numel(zrs);
        end
        t_zrs=zeros(1, nzrs); %allocate memory for times when direction of movement changes
        p_zrs=zeros(1, nzrs); %allocate memory for positions when the direction of movement changes
        
        for i=1:nzrs
            idx1=zrs(i);
            % interpolate for accuracy
            t_zrs(i)=interp1(v(idx1:idx1+1),t(idx1:idx1+1),0,'pchip'); % time of velocity equal to 0
            p_zrs(i)=interp1(t(idx1:idx1+1),p(idx1:idx1+1),t_zrs(i),'pchip'); % position at the time at wich velocity is equal to 0
        end
        
        h2=hist(diff(p_zrs),bins);  %raw
        l2=numel(p_zrs);
        
        emds(id1,id2)=sum(abs(cumsum(h1/l1)-cumsum(h2/l2)))*bin_width/max_emd;
    end
end

emds=emds+triu(emds)';
[xx,ev]=cmdscale(emds); % xx is a matrix that has coordinates in similarity space
% ev is eigenvalues
%
colors=lines(3500);
colors=colors(1:10:end,:);
k=1;
for i=1:9:kk-1
    idx=i:i+8;
    
    % Plot similarity space with ellipses
    figure (1)
    plot(xx(idx,1),xx(idx,2),'*','MarkerSize',3,'color',colors(k,:));
    hold on
    text(mean(xx(idx,1)),mean(xx(idx,2)),num2str(k),'FontSize',15,'FontWeight','bold','color',colors(k,:))
    plotgauss2d([mean(xx(idx,1)) mean(xx(idx,2))]',cov(xx(idx,1),xx(idx,2)),'conf',0.7,'Color',colors(k,:),'LineWidth',1.1);
    k=k+1;
end
% Compute distance between P1 & P2 before (emd_P1_P2) and during the interaction (emd_NI_P1_P2)
ctr=1;
for i=1:36:kk-1
    idx1=i:(i+8);
    idx2=(i+9):(i+17)
    idx3=(i+18):(i+26)
    idx4=(i+27):(i+35)
    emd_P1_P2_neutral(ctr)= mean(mean(emds(idx1,idx2)));
    emd_NI_P1_P2_neutral(ctr)= mean(mean(emds(idx3,idx4)));
    ctr=ctr+1,
end

% Compute distance for P1 & P2 in solo and NI condition
ctr=1;
for i=1:36:kk-1
    idx1=i:(i+8);
    idx2=(i+9):(i+17)
    idx3=(i+18):(i+26)
    idx4=(i+27):(i+35)
    emd_P1(ctr)= mean(mean(emds(idx1,idx3)));
    emd_P2(ctr)= mean(mean(emds(idx2,idx4)));
    ctr=ctr+1,
end