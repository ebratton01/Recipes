pro plotIKTau,smoothFac=smoothFac,rebinFac=rebinFac;,CMB=CMB

  ;if not keyword_set(CMB) then CMB=0

  if not keyword_set(smoothFac) then smoothFac=0

  if not keyword_set(rebinFac) then rebinFac=0
  ;1 | 2 | 23071 | 46142 (4 divisors)
  
 ; if CMB eq 0 then begin

  fits_read,'iktau_feb2020_MRD.fits',im1,hd1
  fits_read,'/Users/emontiel/EXES--PostDoc/Data/AGBStars/pallas/hilo724cm-1/pallas_apr2019_MRD.fits',im2,hd2   


  ;expansion velocity factored in
  dopplerShift = 58.576693
  dopplerShift = dopplerShift/3.0d5
  dS = '58.576693'
  ;no expansion velocity
  dopplerShift2 = 77.576693
  dopplerShift2 = dopplerShift2/3.0d5
  dS2 = '77.576693'

  wv1 = im1[*,0]
  ;fx1 = smooth(im1[*,1]/median(im1[*,1],/even),smoothFac,/nan)
  fx1 = im1[*,1]/median(im1[*,1],/even)
  at1 = im1[*,3]

  if rebinFac gt 0 then begin
     wv1 = frebin(wv1,rebinFac)
     fx1 = frebin(fx1,rebinFac)
     at1 = frebin(at1,rebinFac)
  endif
  
  wv2 = im2[*,0]
  ;fx2 = smooth(im2[*,1]/median(im2[*,1],/even),smoothFac,/nan)
  fx2 = im2[*,1]/median(im2[*,1],/even)
  at2 = im2[*,3]

  ; 1 | 2 | 3 | 4 | 6 | 8 | 12 | 13 | 16 | 24 | 26 | 39 | 48 | 52 | 73 | 78 | 104 | 146 | 156 | 208 | 219 | 292 |
  ; 312 | 438 | 584 | 624 | 876 | 949 | 1168 | 1752 | 1898 | 2847 | 3504 | 3796 | 5694 | 7592 | 11388 | 15184 | 22776 | 45552 (40 divisors)

  wv2 = rebin(wv2,22776)
  fx2 = rebin(fx2,22776)
  at2 = rebin(at2,22776)
     
  x0=701.0
  answer = ''
     
  ;readcol,'synthC2H2_724.txt',wvnC2H2,fxC2H2,format='d,d'
  ;readcol,'synthHCN_724.txt',wvnHCN,fxHCN,format='d,d'
  ;readcol,'synthCO2_724.txt',wvnCO2,fxCO2,format='d,d'
     
  readcol,'/Users/emontiel/EXES--PostDoc/Data/AGBStars/12C-16O2_700-800_700K_0.010000.sigma',wvnCO2,sigCO2,format='d,d'
  readcol,'/Users/emontiel/EXES--PostDoc/Data/AGBStars/1H2-16O_700-800_700K_0.010000.sigma',wvnH2O,sigH2O,format='d,d'
  readcol,'/Users/emontiel/EXES--PostDoc/Data/AGBStars/1H2-16O2_700-800_300K_0.010000.sigma',wvnH2O2,sigH2O2,format='d,d'
  readcol,'/Users/emontiel/EXES--PostDoc/Data/AGBStars/1H2-12C-16O_700-800_300K_0.010000.sigma',wvnH2CO,sigH2CO,format='d,d'
  readcol,'/Users/emontiel/EXES--PostDoc/Data/AGBStars/32S-16O2_700-800_300K_0.010000.sigma',wvnSO2,sigSO2,format='d,d'
  readcol,'/Users/emontiel/EXES--PostDoc/Data/AGBStars/1H-2H-16O_700-800_300K_0.010000.sigma',wvnHDO,sigHDO,format='d,d'

  readcol,'/Users/emontiel/EXES--PostDoc/Data/AGBStars/28Si-32S_700-800_300K_0.010000.sigma',wvnSiS,sigSiS,format='d,d'
  ;readcol,'/Users/emontiel/EXES--PostDoc/Data/AGBStars/23Na-35Cl_700-800_300K_0.010000.sigma',wvnNaCl,sigNaCl,format='d,d'
  ;readcol,'/Users/emontiel/EXES--PostDoc/Data/AGBStars/1H-12C-14N_700-800_700K_0.010000.sigma',wvnHCN,sigHCN,format='d,d'
  ;readcol,'/Users/emontiel/EXES--PostDoc/Data/AGBStars/1H-13C-14N_700-800_700K_0.010000.sigma',wvnH13CN,sigH13CN,format='d,d'
  ;readcol,'/Users/emontiel/EXES--PostDoc/Data/AGBStars/12C2-1H2_700-800_700K_0.010000.sigma',wvnC2H2,sigC2H2,format='d,d'
  ;readcol,'/Users/emontiel/EXES--PostDoc/Data/AGBStars/14N-1H3_700-800_300K_0.010000.sigma',wvnNH3,sigNH3,format='d,d'
  ;readcol,'testO3_100K.txt',wvnO3,fxO3,format='d,d'

  readcol,'foo3.txt',wvnO3,intenO3,format='d,d'
  idx = where(intenO3 ge 6.0d-22,ctO3)
  wvnO3 = wvnO3[idx]
  
  ;stop
  !P.Multi = [0,1,2]
  TVLCT, 255, 255, 255, 254     ; White color
  TVLCT, 0, 0, 0, 253           ; Black color
  !P.Color = 253
  !P.Background = 254

  
  while (x0 le 743) do begin
     ;   idx = where(wv1 ge x0 and wv1 le x0+1.0)
     plot,im1[*,0],im1[*,1],/nodata,charsize=1.5,xrange=[x0,x0+1.0],/xsty,yrange=[-0.15,1.8],/ysty,$
          xtitle='WVN [cm-1]',title='Shift: '+dS+' km s-1'

     ;oplot,wv1*(1+dopplerShift),fx1/ffx2,psym=10
     oplot,wv1*(1+dopplerShift),fx1,psym=10,thick=3
     oplot,wv2*(1+dopplerShift),smooth(fx2,0,/nan),color=150,psym=10,thick=3


        ;oplot,wv1,at1,color=254,linestyle=3
        ;oplot,wv2,at2,color=200,linestyle=3
     
     oplot,wv1*(1+dopplerShift),at1,color=250,linestyle=3,thick=3
     ;   oplot,wv2*(1+dopplerShift[1]),at2,color=254,linestyle=2

     ;   oplot,wvnHCN,fxHCN,color=100
     ;oplot,wvnC2H2,fxC2H2,color=25
     ;oplot,wvnHCN,gauss_smooth(exp(-3d18*sigHCN),2),color=25,thick=2,psym=10
     ;oplot,wvnH13CN,gauss_smooth(exp(-3d18*sigH13CN),2),color=25,thick=2
     ;oplot,wvnC2H2,gauss_smooth(exp(-1d18*sigC2H2),2),color=50,thick=2
     ;oplot,wvnH2O2,gauss_smooth(exp(-3.5d20*sigH2O2),2),color=50,thick=2,psym=10
     ;oplot,wvnNaCl,gauss_smooth(exp(-7.5d20*sigNaCl),2),color=50,thick=2,psym=10
     oplot,wvnH2O,gauss_smooth(exp(-3d20*sigH2O),2),color=100,thick=2,psym=10
     oplot,wvnSiS,gauss_smooth(exp(-1d21*sigSiS),2),color=200,thick=2,psym=10
     for i=0,ctO3-1 do oplot,[wvnO3[i],wvnO3[i]],[-10,10],linestyle=5,color=25,thick=2
     ;oplot,wvnHDO,gauss_smooth(exp(-1d21*sigHDO),2),color=200,thick=2,psym=10
     ;oplot,wvnH2CO,gauss_smooth(exp(-3.5d24*sigH2CO),2),color=150,thick=2,psym=10
     ;oplot,wvnCO2,gauss_smooth(exp(-1d19*sigCO2),2),color=200,thick=2,psym=10
     ;oplot,wvnSO2,gauss_smooth(exp(-5.5d23*sigSO2),2),psym=10,color=200,thick=2
     ;oplot,wvnNH3,gauss_smooth(exp(-1d21*sigNH3),2),color=225,thick=2
     ;oplot,wvnO3,fxO3,color=100,thick=2
     
     ;no expansion velocity

     plot,im1[*,0],im1[*,1],/nodata,charsize=1.5,xrange=[x0,x0+1.0],/xsty,yrange=[-0.15,1.8],/ysty,$
          xtitle='WVN [cm-1]',title='Shift: '+dS2+' km s-1'

     ;oplot,wv1*(1+dopplerShift),fx1/ffx2,psym=10
     oplot,wv1*(1+dopplerShift2),fx1,psym=10,thick=3
     oplot,wv2*(1+dopplerShift2),fx2,color=150,psym=10,thick=3

     oplot,wv1*(1+dopplerShift2),at1,color=250,linestyle=3,thick=3

     ;oplot,wvnC2H2,fxC2H2,color=25
     ;oplot,wvnHCN,gauss_smooth(exp(-3d18*sigHCN),2),color=25,thick=2,psym=10
     ;oplot,wvnH13CN,gauss_smooth(exp(-3d18*sigH13CN),2),color=25,thick=2
     ;oplot,wvnC2H2,gauss_smooth(exp(-1d18*sigC2H2),2),color=50,thick=2
     ;oplot,wvnH2O2,gauss_smooth(exp(-3.5d20*sigH2O2),2),color=50,thick=2,psym=10
     ;oplot,wvnNaCl,gauss_smooth(exp(-7.5d20*sigNaCl),2),color=50,thick=2,psym=10
     oplot,wvnH2O,gauss_smooth(exp(-3d20*sigH2O),2),color=100,thick=2,psym=10
     oplot,wvnSiS,gauss_smooth(exp(-1d21*sigSiS),2),color=200,thick=2,psym=10
     for i=0,ctO3-1 do oplot,[wvnO3[i],wvnO3[i]],[-10,10],linestyle=5,color=25,thick=2
     ;oplot,wvnHDO,gauss_smooth(exp(-1d21*sigHDO),2),color=200,thick=2,psym=10
     ;oplot,wvnSO2,gauss_smooth(exp(-5.5d23*sigSO2),2),psym=10,color=200,thick=2
     ;oplot,wvnH2CO,gauss_smooth(exp(-3.5d24*sigH2CO),2),color=150,thick=2,psym=10
     ;oplot,wvnCO2,gauss_smooth(exp(-1d19*sigCO2),2),color=200,thick=2,psym=10
     ;oplot,wvnNH3,gauss_smooth(exp(-1d21*sigNH3),2),color=225,thick=2
     ;oplot,wvnO3,fxO3,color=100,thick=2
     ;oplot,wvnCO2,fxCO2*1.4,color=225
     
     read,answer
     x0 = x0+0.25
  endwhile
  ;endif else begin

  ;   fits_read,'vxsgr_oct2018_CMB.fits',im1,hd1
  ;   fits_read,'vxsgr_apr2019_CMB.fits',im2,hd2
     
     
  ;   dopplerShift = [-30.3667889204,-85.552648]
  ;   dopplerShift = dopplerShift/3.0d5
  ;   answer = ''
     
  ;   for i=0,58 do begin
  ;      wv1 = im1[*,0,i]
  ;      fx1 = im1[*,1,i]/median(im1[*,1,i],/even)
  ;      at1 = im1[*,3,i]
     
  ;      wv2 = im2[*,0,i+3]
  ;      fx2 = im2[*,1,i+3]/median(im2[*,1,i+3],/even)
  ;      at2 = im2[*,3,i+3]

  ;      plot,wv1,fx1,/nodata,charsize=1.5,xtitle='WVN [cm-1]',xrange=[min(wv1)-0.1,max(wv2)+0.1],/xsty,$
  ;                                                                   yrange=[-0.1,3.0],/ysty

  ;      oplot,wv1,smooth(fx1,5,/nan),ps=10
  ;      oplot,wv2,smooth(fx2,5,/nan),color=150,ps=10

  ;      oplot,wv1,at1,color=254,linestyle=3
  ;      oplot,wv2,at2,color=200,linestyle=3
  ;      read,answer
  ;   endfor
     
  !P.Multi=[0,0,0]

  ;endelse
  ;stop
end



;oplot,im1[*,0]*(1+dopplerShift),im1[*,3]*200.,color=254,linestyle=2
;oplot,wvnCO2,fxCO2*170.,color=200


;plot,wv1*(1+dopplerShift),fx1/ffx2,xrange=[736,740],/xsty,psym=10
;oplot,wv1*(1+dopplerShift),ffx2,color=225,linestyle=4            
;oplot,wv1*(1+dopplerShift),fx1,color=150,linestyle=4             
;oplot,wv1*(1+dopplerShift[0]),at1,color=254,linestyle=3
;oplot,wvnCO2,fxCO2,color=200                                     
