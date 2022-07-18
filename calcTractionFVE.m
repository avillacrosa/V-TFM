function [emax, n, p, settings, tmax]=calcTractionFVE(emax, n, p, settings, tmax)
	for e=1:emax
		load(fullfile(p.images.bestryps{e},['properties','.mat']));
		for it=1:tmax(e)
            if it==1
                disptrac_1=load([p.files.pivdisptrac{e},n.files.pivdisp{e,it}]);
                Nsz=numel(unique(disptrac_1(:,1)));%xx is the horizontal size of disp/trac grid
                Msz=numel(unique(disptrac_1(:,2)));%yy is the vertical size of disp/trac grid
                dfieldx=NaN([Msz,Nsz,tmax(e)]);%3D matrix of time-lapse of displacement-field grid on phase contrast (x-component)
                dfieldy=NaN([Msz,Nsz,tmax(e)]);%3D matrix of time-lapse of displacement-field grid on phase contrast (y-component)
                xlocs=NaN([Msz,Nsz,tmax(e)]);%3D matrix of time-lapse of locations-field grid on phase contrast (x-component)
                ylocs=NaN([Msz,Nsz,tmax(e)]);%3D matrix of time-lapse of locations-field grid on phase contrast (y-component)
				ux_t = zeros(Msz, Nsz, tmax(e));
				uy_t = zeros(Msz, Nsz, tmax(e));
            end
                       
            disptrac_t=load(fullfile(p.files.pivdisptrac{e},n.files.pivdisp{e,it}),'pivmatrix','-ascii');
            xlocs(:,:,it)=reshape(disptrac_t(:,1),[Msz,Nsz]);%x-locs are in column #1
            ylocs(:,:,it)=reshape(disptrac_t(:,2),[Msz,Nsz]);%y-disps are in column #2
            dfieldx(:,:,it)=reshape(disptrac_t(:,3),[Msz,Nsz]);%x-disps are in column #3 (in image pixels)
            dfieldy(:,:,it)=reshape(disptrac_t(:,4),[Msz,Nsz]);%y-disps are in column #4 (in image pixels)
     
            %start filter
            if settings.filterdisps~=0
                addpath(p.FIG);
                dispmags=sqrt(dfieldx(:,:,it).^2+dfieldy(:,:,it).^2);
                [iqr_mid_disp,iqr_range_disp,iqr_epts_disp,iqr_whisks_disp]=boxplotvals(dispmags(:));
                dispmags_upbound(1)=iqr_whisks_disp(2);%upper whisker
                dispmags_upbound(2)=nanmean(dispmags(:))+2*nanstd(dispmags(:));%mean+std
                
                disptrac_t=load(fullfile(p.files.pivdisptrac{e},n.files.pivdisp{e,it}),'pivmatrix','-ascii');
                nfux=squeeze(dfieldx(:,:,it));%non-filtered x-disp
                nfuy=squeeze(dfieldy(:,:,it));%non-filtered y-disp
                nfmags=sqrt(nfux(:).^2+nfuy(:).^2);
                nfux(nfmags>dispmags_upbound(settings.filterdisps))=NaN;%filter displacements
                nfuy(nfmags>dispmags_upbound(settings.filterdisps))=NaN;%filter displacements
				rmpath(p.FIG);
                addpath(p.PIVlab);
                ux=inpaint_nans_PIVLAB(nfux,1);
                uy=inpaint_nans_PIVLAB(nfuy,1);
                addpath(p.PIVlab);
            else                
                addpath(p.PIVlab);
                ux=inpaint_nans_PIVLAB(squeeze(dfieldx(:,:,it)),1);%inpaint nans occurring from PIV
                uy=inpaint_nans_PIVLAB(squeeze(dfieldy(:,:,it)),1);
                rmpath(p.PIVlab);
            end
            
            if settings.purgedispdrift~=0
                switch settings.purgedispdrift
                    case{1}%clear mean displacement of the gel
                        ux=ux-nanmean(ux(:));
                        uy=uy-nanmean(uy(:));
                    case{2}%clear modal displacement of the gel
                            %not implemented yet
                end
            end
            
            addpath(p.TFMlab);
            ux_in_metres=ux*settings.pixelsize_in_metres;%displacements in metres to have tractions in Pascal
            uy_in_metres=uy*settings.pixelsize_in_metres;%displacements in metres to have tractions in Pascal
			ux_t(:,:,it) = ux_in_metres;
			uy_t(:,:,it) = uy_in_metres;
			rmpath(p.TFMlab);
		end
        [tx_t, ty_t] = shrineRunTFM(settings.tInt, settings.E,settings.nu,settings.d,settings.H,ux_t,uy_t,settings.nz);
		for it=1:tmax(e)
    		disptrac_t=load(fullfile(p.files.pivdisptrac{e},n.files.pivdisp{e,it}),'pivmatrix','-ascii');
			tx = tx_t(:,:,it); ux = ux_t(:,:,it);
			ty = ty_t(:,:,it); uy = uy_t(:,:,it);
			if settings.equiltracs~=0
				switch settings.equiltracs
					case{1}%clear resultant of traction field
    					tx=tx-nansum(tx(:));
    					ty=ty-nansum(ty(:));
					case{2}%clear resultant and moment of traction field
        					%not implemented yet
				end
			end
    		disptrac_t(:,3)=ux(:);%inpainted disps
    		disptrac_t(:,4)=uy(:);
    		disptrac_t(:,5)=tx(:);
    		disptrac_t(:,6)=ty(:);
    		save(fullfile(p.files.pivdisptrac{e},n.files.filtdisptrac{e,it}),'disptrac_t','-ascii');
		end
	end
end