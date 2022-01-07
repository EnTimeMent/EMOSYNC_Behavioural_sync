function [RVE,RVEMEAN] = f_CalculateRVE(VELOCITY)

% Relative Velocity Error to estimate the relation Leader Follower
% As in paper from Slowinsky
% BUT here (Position, Velocity) is remplaced by (Velocity, Acceleration)

GLOBAL_; % global variables
N = length(VELOCITY);
RVE = []; RVEMEAN = zeros(N);

for p = 1 : N - 1
    
    for q = p+1 : N
        
        Vp = VELOCITY{p};  Tp = length(Vp);
        Vq = VELOCITY{q};  Tq = length(Vq);
        
        T = min(Tp,Tq); Vp = Vp(1 : T); Vq = Vq(1 : T); 
        Ap = gradient(Vp); Aq = gradient(Vq);
        % rve
        rve_pq = abs(Vp - Vq); rve_qp = rve_pq;      
        Sp = sign(Ap); Sq = sign(Aq);
        Ipq = and(Sp ~= 0, Sp == Sq);
        rve_pq(Ipq) = (Vp(Ipq) - Vq(Ipq)) .* Sp(Ipq);
        Iqp = and(Sq ~= 0, Sp == Sq);
        rve_qp(Iqp) = (Vq(Iqp) - Vp(Iqp)) .* Sq(Iqp);
        
        RVEMEAN(p,q) = mean(rve_pq);
        RVEMEAN(q,p) = mean(rve_qp);
        
        %         Parameters.Visu = false;
        Visu = false;
        if Visu %Parameters.Visu
            figure(5), clf
            Iax = 1 : 500;
            ax = (1 : T)/ViconFrequency;
            ax = ax(Iax);
            subplot(311)
            plot(ax,Vp(Iax),'-r',ax,Vq(Iax),'-b')
            legend('VEL 1','VEL 2'), xlabel('Time'), grid on
            subplot(312)
            plot(ax,Ap(Iax),'-r',ax,Aq(Iax),'-b')
            legend('ACC 1','ACC 2'), xlabel('Time'), grid on
            
            subplot(313)
            plot(ax,rve_pq(Iax),'-r',ax,rve_qp(Iax),'-b')
            legend('LEADER 1','LEADER 2')
            title(['RVE(1,2): ',num2str(RVEMEAN(p,q)),' RVE(2,1): ',num2str(RVEMEAN(q,p))])
            xlabel('Time'), grid on            
        end
        'wait'
    end
end