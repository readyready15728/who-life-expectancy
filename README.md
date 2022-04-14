# WHO Life Expectancy
## SVM-based prediction of life expectancy from 2014 WHO data

Temporary description, first the output:

```
[1] "Printing out test predictions:"
# A tibble: 37 × 3
   country                                            life_expectancy prediction
   <chr>                                                        <dbl>      <dbl>
 1 Armenia                                                       74.6       75.9
 2 Australia                                                     82.7       82.3
 3 Azerbaijan                                                    72.5       74.4
 4 Bahamas                                                       75.4       77.2
 5 Belize                                                        70         72.5
 6 Bhutan                                                        69.4       70.7
 7 Côte d'Ivoire                                                 52.8       68.6
 8 Congo                                                         64.2       60.4
 9 Czechia                                                       78.6       73.5
10 Democratic People's Republic of Korea                         73         72.5
11 Democratic Republic of the Congo                              59.3       68.9
12 Djibouti                                                      63         61.1
13 Egypt                                                         78         71.1
14 France                                                        82.2       83.7
15 Gambia                                                        68         60.7
16 Georgia                                                       74.5       75.9
17 Iran (Islamic Republic of)                                    75.4       74.6
18 Iraq                                                          67.9       67.1
19 Lao People's Democratic Republic                              65.3       66.1
20 Madagascar                                                    65.1       61.7
21 Nigeria                                                       53.6       70.8
22 Norway                                                        81.6       78.6
23 Oman                                                          76.4       74.4
24 Peru                                                          75.3       74.1
25 Philippines                                                   68.4       72.1
26 Portugal                                                      89         76.8
27 Samoa                                                         73.8       73.5
28 Slovenia                                                      87         79.5
29 Solomon Islands                                               68.8       66.9
30 South Sudan                                                   56.6       63.7
31 Thailand                                                      74.6       71.5
32 Timor-Leste                                                   68         68.4
33 Uganda                                                        61.5       62.6
34 United Kingdom of Great Britain and Northern Irel…            81         76.5
35 Vanuatu                                                       71.7       69.8
36 Venezuela (Bolivarian Republic of)                            73.9       75.1
37 Zambia                                                        61.1       58.8
```

That feel when you got all the tidyverse packages to cooperate with you
without needing any help and you achieved a decent RMSE despite bombing on a
some countries, most notably Nigeria.

![the Techpriest from "Armouring of a Space Marine](exultant-techpriest.png)
