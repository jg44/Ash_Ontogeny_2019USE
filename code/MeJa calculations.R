mw <- 224.3 #g/mol for MeJa


mass (g) = conc (mol/L) * vol(L) * mw (g/mol)


#for the fisher order where we should be receiving 25g and we want 1M
C=1
25 g = C*V*mw

OR

(V=25/mw)
[1] 0.1114579

So we can make
111.4 L or 111.4 mL MeJa at 1M with 25g

dissolved in WHAT I don't know. Ethanol maybe?


From Sigma:


Related Categories	Building Blocks, C12 to C63, Carbonyl Compounds, Chemical Synthesis, Esters,
More...
InChI Key  	GEWDNTWNSAZUDX-SNAWJCMRSA-N
assay  	95%
refractive index  	n20/D 1.474(lit.)
bp  	110 ?C/0.2 mmHg(lit.)
solubility  	water: soluble 340 mg/L at 25 ?C(lit.)
density  	1.03 g/mL at 25 ?C(lit.)
https://www.sigmaaldrich.com/catalog/product/aldrich/392707?lang=en&region=US

# for the sigma order where we got 95% in solution


then this would mean we have 25*1.03*.95
sigmaMassMeJa <- 25*1.03*.95
[1] 24.4625 g

and the 

sigmaMassMeJa/mw

SO:
0.1090615 L or 109.1 mL 

In other words, if we add 109.1-25ml = 84.1 mL of water to each bottle, we should get 109.1 mL total 1M MeJa

Since there are two bottles, we have ~220 mL

Plus the 111.4 mL when the Fisher order comes....so 

109.1*2+111.4 = 329.6 ml total.  

Does this seem right??!

