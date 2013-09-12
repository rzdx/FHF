function [ O ] = fznb( I ) % fuzzy neighbor filter
Di=DI(I);
%O=Y(I,di);
O=zeros(size(I,1),size(I,2),size(I,3));
%nosleft=sum(sum(Di));
% alpha
ccc=0.006;
www=0.003;
B={ccc-www,ccc,ccc+www,ccc+(2*www),0.5};
S={www,www,www,www,0.5};
M={exp(-1),1,exp(-1),exp(-4),0};
% alpha
for r=1:size(I,1)
	for c=1:size(I,2)
		if Di(r,c)==1
			%nosleft=nosleft-1
			L=Lvar(Di,r,c);
			[SbI,tr,tc]=fn.winsp(I,r,c,L);
			SbDi=fn.winsp(Di,r,c,L);
			%[sr,sc]=scord(SbI,SbDi,tr,tc,getnzfp(SbDi));
			rmin=realmax;
			NFP=getnzfp(SbDi);
			mr=0;
			mc=0;
			for scr=1:size(SbI,1)
				for scc=1:size(SbI,2)
					if SbDi(scr,scc)==1 % if is_noise(SbI(r,c))=true then ignore
						continue;
					end
					%estp
					eu=zeros(1,1,size(SbI,3));
					ed=0;
					for i=1:length(NFP)
						Ip=SbI(NFP{i}(1),NFP{i}(2),:);
						%alpha
						au=0;
						ad=0;
						for ai=1:length(B)
							%t=tk(SbI,SbDi,Ip,B{ai},S{ai});
							%tu=(siml(SbI,SbDi,Ip)-b)^2;
							%siml
							slsum=0;
							ct=0;
							for slr=1:size(SbI,1)
								for slc=1:size(SbI,2)
									if SbDi(slr,slc)==1 % exclude noise points
										continue;
									end
									sbip1=SbI(slr,slc,:);
									slsum=slsum+norm(Ip(:)-sbip1(:));
									%        slsum=slsum+sqrt(sum((Ip-SbI(slr,slc,:)).^2));
									ct=ct+1;
								end
							end
							silmO=slsum/(3*255*ct);
							%siml
							tu=(silmO-B{ai})^2;
							td=2*((S{ai})^2);
							t=exp(-(tu/td));
							au=au+(t*M{ai});
							ad=ad+t;
						end
						al=au/ad;
						%alpha
						%al=alpha(SbI,SbDi,Ip);
						eu=eu+(al*Ip);
						ed=ed+al;
					end
					estp=eu/ed;
					sbip=SbI(scr,scc,:);
					%estp
					%estp=estipx(SbI,SbDi,NFP);
					dt=norm(double(sbip(:))-double(estp(:))); % else then take into consideration
					if rmin>dt
						rmin=dt;
						mr=scr;
						mc=scc;
					end
				end
			end
			sr=mr+tr-1;
			sc=mc+tc-1;
			O(r,c,:)=I(sr,sc,:);
		else
			O(r,c,:)=I(r,c,:);
		end
	end
end
end
%
% function [O]=Y(I,Di) % output result pixel
% [R,C,D]=fn.getsz(I);
% O=zeros(R,C,D);
% %nosleft=sum(sum(Di));
%     for r=1:R
%         for c=1:C
%             if Di(r,c)==1
%                 %nosleft=nosleft-1
%                 L=Lvar(Di,r,c);
%                 [SbI,tr,tc]=fn.winsp(I,r,c,L);
%                 SbDi=fn.winsp(Di,r,c,L);
%                 [sr,sc]=scord(SbI,SbDi,tr,tc,getnzfp(SbDi));
%                 O(r,c,:)=I(sr,sc,:);
%             else
%                 O(r,c,:)=I(r,c,:);
%             end
%         end
%     end
% end
%
% function [sr,sc]=scord(SbI,SbDi,topR,topC,NFP) % output the position of min-distance point for points within SbI between some noise-free points within SbI
% rmin=realmax;
% mr=0;
% mc=0;
% for scr=1:size(SbI,1)
%     for scc=1:size(SbI,2)
%         if SbDi(scr,scc)==1 % if is_noise(SbI(r,c))=true then ignore
%             continue;
%         end
%         dt=fn.dst(SbI(scr,scc,:),estipx(SbI,SbDi,NFP)); % else then take into consideration
%         if rmin>dt
%            rmin=dt;
%            mr=scr;
%            mc=scc;
%         end
%     end
% end
% sr=mr+topR-1;
% sc=mc+topC-1;
% end
%
% function [O]=estipx(SbI,SbDi,NFP) % get estimated pixel
%         u=zeros(1,1,size(SbI,3));
%         d=0;
%         for i=1:length(NFP)
%             Ip=SbI(NFP{i}(1),NFP{i}(2),:);
%             al=alpha(SbI,SbDi,Ip);
%             u=u+(al*Ip);
%             d=d+al;
%         end
%         O=u/d;
% end
%
% function [O]=alpha(SbI,SbDi,Ip)
%
%
% au=0;
% ad=0;
% for i=1:length(B)
%     t=tk(SbI,SbDi,Ip,B{i},S{i});
%     au=au+(t*M{i});
%     ad=ad+t;
% end
% O=au/ad;
% end
%
% function [O]=tk(SbI,SbDi,Ip,b,s)
% tu=(siml(SbI,SbDi,Ip)-b)^2;
% td=2*((s)^2);
% O=exp(-(tu/td));
% end
%
% function [O]=siml(SbI,SbDi,Ip) % get ~similarity_value
% [R,C]=fn.getsz(SbI);
% MAXI=255;
% s=0;
% ct=0;
% for r=1:R
%     for c=1:C
%         if SbDi(r,c)==1 % exclude noise points
%             continue;
%         end
%         s=s+fn.dst(Ip,SbI(r,c,:));
%         ct=ct+1;
%     end
% end
% O=s/(3*MAXI*ct);
% end

function [O]=Lvar(Di,r,c) % output min length of a window centered at (r,c) with some noise-free points within
chk=0;
for L=3:2:min(size(Di,1),size(Di,2))
	SbDi=fn.winsp(Di,r,c,L);
	if sum(SbDi(:))~=size(SbDi,1)*size(SbDi,2)
		chk=1;
		break;
	end
end
if chk
	O=L;
else
	error('L out_of_bound')
end
end

function [O]=getnzfp(SbDi) % get noise-free points within sub-Di(=SbDi)
pct=size(SbDi,1)*size(SbDi,2)-sum(SbDi(:));
O=cell(1,pct);
ct=0;
for r=1:size(SbDi,1)
	for c=1:size(SbDi,2)
		if SbDi(r,c)==0
			ct=ct+1;
			O{ct}=[r,c];
		end
	end
end
end

function [O]= DI(I) % get noise_tag_matrix with 1=noise_point,0=noise-free_point
O=zeros(size(I,1),size(I,2));
for j=1:size(I,3)
	Ie=I(:,:,j);
	for i=1:size(I,1)*size(I,2)
		if Ie(i)==255||Ie(i)==0
			O(i)=1;
		end
	end
end
end
