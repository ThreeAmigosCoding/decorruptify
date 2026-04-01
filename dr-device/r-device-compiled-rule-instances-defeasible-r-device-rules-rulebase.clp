([pen_424b_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_424b_max-defeasibly-dot-gen402)
   (depends-on declare max_imprisonment art424_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_424b_max] ) ) ) ?gen358 <- ( max_imprisonment ( value 5 ) ( positive 1 ) ( positive-derivator pen_424b_max $? ) ) ( test ( eq ( class ?gen358 ) max_imprisonment ) ) ( not ( and ?gen365 <- ( art424_basic ( defendant ?Defendant ) ( positive ?gen364 & : ( >= ?gen364 1 ) ) ) ?gen358 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen360 & : ( not ( member$ pen_424b_max $?gen360 ) ) ) ) ) ) => ?gen358 <- ( max_imprisonment ( positive 0 ) )"))

([pen_424b_max-defeasibly] of derived-attribute-rule
   (pos-name pen_424b_max-defeasibly-gen404)
   (depends-on declare art424_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_424b_max] ) ) ) ?gen365 <- ( art424_basic ( defendant ?Defendant ) ( positive ?gen364 & : ( >= ?gen364 1 ) ) ) ?gen358 <- ( max_imprisonment ( value 5 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen360 & : ( not ( member$ pen_424b_max $?gen360 ) ) ) ) ( test ( eq ( class ?gen358 ) max_imprisonment ) ) => ?gen358 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_424b_max ?gen365 ) )"))

([pen_424b_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_424b_max-overruled-dot-gen406)
   (depends-on declare max_imprisonment art424_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_424b_max] ) ) ) ?gen358 <- ( max_imprisonment ( value 5 ) ( negative-support $?gen361 ) ( negative-overruled $?gen362 & : ( subseq-pos ( create$ pen_424b_max-overruled $?gen361 $$$ $?gen362 ) ) ) ) ( test ( eq ( class ?gen358 ) max_imprisonment ) ) ( not ( and ?gen365 <- ( art424_basic ( defendant ?Defendant ) ( positive ?gen364 & : ( >= ?gen364 1 ) ) ) ?gen358 <- ( max_imprisonment ( positive-defeated $?gen360 & : ( not ( member$ pen_424b_max $?gen360 ) ) ) ) ) ) => ( calc ( bind $?gen363 ( delete-member$ $?gen362 ( create$ pen_424b_max-overruled $?gen361 ) ) ) ) ?gen358 <- ( max_imprisonment ( negative-overruled $?gen363 ) )"))

([pen_424b_max-overruled] of derived-attribute-rule
   (pos-name pen_424b_max-overruled-gen408)
   (depends-on declare art424_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_424b_max] ) ) ) ?gen365 <- ( art424_basic ( defendant ?Defendant ) ( positive ?gen364 & : ( >= ?gen364 1 ) ) ) ?gen358 <- ( max_imprisonment ( value 5 ) ( negative-support $?gen361 ) ( negative-overruled $?gen362 & : ( not ( subseq-pos ( create$ pen_424b_max-overruled $?gen361 $$$ $?gen362 ) ) ) ) ( positive-defeated $?gen360 & : ( not ( member$ pen_424b_max $?gen360 ) ) ) ) ( test ( eq ( class ?gen358 ) max_imprisonment ) ) => ( calc ( bind $?gen363 ( create$ pen_424b_max-overruled $?gen361 $?gen362 ) ) ) ?gen358 <- ( max_imprisonment ( negative-overruled $?gen363 ) )"))

([pen_424b_max-support] of derived-attribute-rule
   (pos-name pen_424b_max-support-gen410)
   (depends-on declare art424_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_424b_max] ) ) ) ?gen357 <- ( art424_basic ( defendant ?Defendant ) ) ?gen358 <- ( max_imprisonment ( value 5 ) ( positive-support $?gen360 & : ( not ( subseq-pos ( create$ pen_424b_max ?gen357 $$$ $?gen360 ) ) ) ) ) ( test ( eq ( class ?gen358 ) max_imprisonment ) ) => ( calc ( bind $?gen363 ( create$ pen_424b_max ?gen357 $?gen360 ) ) ) ?gen358 <- ( max_imprisonment ( positive-support $?gen363 ) )"))

([pen_424b_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_424b_min-defeasibly-dot-gen412)
   (depends-on declare min_imprisonment art424_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_424b_min] ) ) ) ?gen349 <- ( min_imprisonment ( value 1 ) ( positive 1 ) ( positive-derivator pen_424b_min $? ) ) ( test ( eq ( class ?gen349 ) min_imprisonment ) ) ( not ( and ?gen356 <- ( art424_basic ( defendant ?Defendant ) ( positive ?gen355 & : ( >= ?gen355 1 ) ) ) ?gen349 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen351 & : ( not ( member$ pen_424b_min $?gen351 ) ) ) ) ) ) => ?gen349 <- ( min_imprisonment ( positive 0 ) )"))

([pen_424b_min-defeasibly] of derived-attribute-rule
   (pos-name pen_424b_min-defeasibly-gen414)
   (depends-on declare art424_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_424b_min] ) ) ) ?gen356 <- ( art424_basic ( defendant ?Defendant ) ( positive ?gen355 & : ( >= ?gen355 1 ) ) ) ?gen349 <- ( min_imprisonment ( value 1 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen351 & : ( not ( member$ pen_424b_min $?gen351 ) ) ) ) ( test ( eq ( class ?gen349 ) min_imprisonment ) ) => ?gen349 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_424b_min ?gen356 ) )"))

([pen_424b_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_424b_min-overruled-dot-gen416)
   (depends-on declare min_imprisonment art424_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_424b_min] ) ) ) ?gen349 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen352 ) ( negative-overruled $?gen353 & : ( subseq-pos ( create$ pen_424b_min-overruled $?gen352 $$$ $?gen353 ) ) ) ) ( test ( eq ( class ?gen349 ) min_imprisonment ) ) ( not ( and ?gen356 <- ( art424_basic ( defendant ?Defendant ) ( positive ?gen355 & : ( >= ?gen355 1 ) ) ) ?gen349 <- ( min_imprisonment ( positive-defeated $?gen351 & : ( not ( member$ pen_424b_min $?gen351 ) ) ) ) ) ) => ( calc ( bind $?gen354 ( delete-member$ $?gen353 ( create$ pen_424b_min-overruled $?gen352 ) ) ) ) ?gen349 <- ( min_imprisonment ( negative-overruled $?gen354 ) )"))

([pen_424b_min-overruled] of derived-attribute-rule
   (pos-name pen_424b_min-overruled-gen418)
   (depends-on declare art424_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_424b_min] ) ) ) ?gen356 <- ( art424_basic ( defendant ?Defendant ) ( positive ?gen355 & : ( >= ?gen355 1 ) ) ) ?gen349 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen352 ) ( negative-overruled $?gen353 & : ( not ( subseq-pos ( create$ pen_424b_min-overruled $?gen352 $$$ $?gen353 ) ) ) ) ( positive-defeated $?gen351 & : ( not ( member$ pen_424b_min $?gen351 ) ) ) ) ( test ( eq ( class ?gen349 ) min_imprisonment ) ) => ( calc ( bind $?gen354 ( create$ pen_424b_min-overruled $?gen352 $?gen353 ) ) ) ?gen349 <- ( min_imprisonment ( negative-overruled $?gen354 ) )"))

([pen_424b_min-support] of derived-attribute-rule
   (pos-name pen_424b_min-support-gen420)
   (depends-on declare art424_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_424b_min] ) ) ) ?gen348 <- ( art424_basic ( defendant ?Defendant ) ) ?gen349 <- ( min_imprisonment ( value 1 ) ( positive-support $?gen351 & : ( not ( subseq-pos ( create$ pen_424b_min ?gen348 $$$ $?gen351 ) ) ) ) ) ( test ( eq ( class ?gen349 ) min_imprisonment ) ) => ( calc ( bind $?gen354 ( create$ pen_424b_min ?gen348 $?gen351 ) ) ) ?gen349 <- ( min_imprisonment ( positive-support $?gen354 ) )"))

([pen_423q_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_423q_max-defeasibly-dot-gen422)
   (depends-on declare max_imprisonment art423_qualified max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_423q_max] ) ) ) ?gen340 <- ( max_imprisonment ( value 12 ) ( positive 1 ) ( positive-derivator pen_423q_max $? ) ) ( test ( eq ( class ?gen340 ) max_imprisonment ) ) ( not ( and ?gen347 <- ( art423_qualified ( defendant ?Defendant ) ( positive ?gen346 & : ( >= ?gen346 1 ) ) ) ?gen340 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen342 & : ( not ( member$ pen_423q_max $?gen342 ) ) ) ) ) ) => ?gen340 <- ( max_imprisonment ( positive 0 ) )"))

([pen_423q_max-defeasibly] of derived-attribute-rule
   (pos-name pen_423q_max-defeasibly-gen424)
   (depends-on declare art423_qualified max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_423q_max] ) ) ) ?gen347 <- ( art423_qualified ( defendant ?Defendant ) ( positive ?gen346 & : ( >= ?gen346 1 ) ) ) ?gen340 <- ( max_imprisonment ( value 12 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen342 & : ( not ( member$ pen_423q_max $?gen342 ) ) ) ) ( test ( eq ( class ?gen340 ) max_imprisonment ) ) => ?gen340 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_423q_max ?gen347 ) )"))

([pen_423q_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_423q_max-overruled-dot-gen426)
   (depends-on declare max_imprisonment art423_qualified max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_423q_max] ) ) ) ?gen340 <- ( max_imprisonment ( value 12 ) ( negative-support $?gen343 ) ( negative-overruled $?gen344 & : ( subseq-pos ( create$ pen_423q_max-overruled $?gen343 $$$ $?gen344 ) ) ) ) ( test ( eq ( class ?gen340 ) max_imprisonment ) ) ( not ( and ?gen347 <- ( art423_qualified ( defendant ?Defendant ) ( positive ?gen346 & : ( >= ?gen346 1 ) ) ) ?gen340 <- ( max_imprisonment ( positive-defeated $?gen342 & : ( not ( member$ pen_423q_max $?gen342 ) ) ) ) ) ) => ( calc ( bind $?gen345 ( delete-member$ $?gen344 ( create$ pen_423q_max-overruled $?gen343 ) ) ) ) ?gen340 <- ( max_imprisonment ( negative-overruled $?gen345 ) )"))

([pen_423q_max-overruled] of derived-attribute-rule
   (pos-name pen_423q_max-overruled-gen428)
   (depends-on declare art423_qualified max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_423q_max] ) ) ) ?gen347 <- ( art423_qualified ( defendant ?Defendant ) ( positive ?gen346 & : ( >= ?gen346 1 ) ) ) ?gen340 <- ( max_imprisonment ( value 12 ) ( negative-support $?gen343 ) ( negative-overruled $?gen344 & : ( not ( subseq-pos ( create$ pen_423q_max-overruled $?gen343 $$$ $?gen344 ) ) ) ) ( positive-defeated $?gen342 & : ( not ( member$ pen_423q_max $?gen342 ) ) ) ) ( test ( eq ( class ?gen340 ) max_imprisonment ) ) => ( calc ( bind $?gen345 ( create$ pen_423q_max-overruled $?gen343 $?gen344 ) ) ) ?gen340 <- ( max_imprisonment ( negative-overruled $?gen345 ) )"))

([pen_423q_max-support] of derived-attribute-rule
   (pos-name pen_423q_max-support-gen430)
   (depends-on declare art423_qualified max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_423q_max] ) ) ) ?gen339 <- ( art423_qualified ( defendant ?Defendant ) ) ?gen340 <- ( max_imprisonment ( value 12 ) ( positive-support $?gen342 & : ( not ( subseq-pos ( create$ pen_423q_max ?gen339 $$$ $?gen342 ) ) ) ) ) ( test ( eq ( class ?gen340 ) max_imprisonment ) ) => ( calc ( bind $?gen345 ( create$ pen_423q_max ?gen339 $?gen342 ) ) ) ?gen340 <- ( max_imprisonment ( positive-support $?gen345 ) )"))

([pen_423q_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_423q_min-defeasibly-dot-gen432)
   (depends-on declare min_imprisonment art423_qualified min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_423q_min] ) ) ) ?gen331 <- ( min_imprisonment ( value 2 ) ( positive 1 ) ( positive-derivator pen_423q_min $? ) ) ( test ( eq ( class ?gen331 ) min_imprisonment ) ) ( not ( and ?gen338 <- ( art423_qualified ( defendant ?Defendant ) ( positive ?gen337 & : ( >= ?gen337 1 ) ) ) ?gen331 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen333 & : ( not ( member$ pen_423q_min $?gen333 ) ) ) ) ) ) => ?gen331 <- ( min_imprisonment ( positive 0 ) )"))

([pen_423q_min-defeasibly] of derived-attribute-rule
   (pos-name pen_423q_min-defeasibly-gen434)
   (depends-on declare art423_qualified min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_423q_min] ) ) ) ?gen338 <- ( art423_qualified ( defendant ?Defendant ) ( positive ?gen337 & : ( >= ?gen337 1 ) ) ) ?gen331 <- ( min_imprisonment ( value 2 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen333 & : ( not ( member$ pen_423q_min $?gen333 ) ) ) ) ( test ( eq ( class ?gen331 ) min_imprisonment ) ) => ?gen331 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_423q_min ?gen338 ) )"))

([pen_423q_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_423q_min-overruled-dot-gen436)
   (depends-on declare min_imprisonment art423_qualified min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_423q_min] ) ) ) ?gen331 <- ( min_imprisonment ( value 2 ) ( negative-support $?gen334 ) ( negative-overruled $?gen335 & : ( subseq-pos ( create$ pen_423q_min-overruled $?gen334 $$$ $?gen335 ) ) ) ) ( test ( eq ( class ?gen331 ) min_imprisonment ) ) ( not ( and ?gen338 <- ( art423_qualified ( defendant ?Defendant ) ( positive ?gen337 & : ( >= ?gen337 1 ) ) ) ?gen331 <- ( min_imprisonment ( positive-defeated $?gen333 & : ( not ( member$ pen_423q_min $?gen333 ) ) ) ) ) ) => ( calc ( bind $?gen336 ( delete-member$ $?gen335 ( create$ pen_423q_min-overruled $?gen334 ) ) ) ) ?gen331 <- ( min_imprisonment ( negative-overruled $?gen336 ) )"))

([pen_423q_min-overruled] of derived-attribute-rule
   (pos-name pen_423q_min-overruled-gen438)
   (depends-on declare art423_qualified min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_423q_min] ) ) ) ?gen338 <- ( art423_qualified ( defendant ?Defendant ) ( positive ?gen337 & : ( >= ?gen337 1 ) ) ) ?gen331 <- ( min_imprisonment ( value 2 ) ( negative-support $?gen334 ) ( negative-overruled $?gen335 & : ( not ( subseq-pos ( create$ pen_423q_min-overruled $?gen334 $$$ $?gen335 ) ) ) ) ( positive-defeated $?gen333 & : ( not ( member$ pen_423q_min $?gen333 ) ) ) ) ( test ( eq ( class ?gen331 ) min_imprisonment ) ) => ( calc ( bind $?gen336 ( create$ pen_423q_min-overruled $?gen334 $?gen335 ) ) ) ?gen331 <- ( min_imprisonment ( negative-overruled $?gen336 ) )"))

([pen_423q_min-support] of derived-attribute-rule
   (pos-name pen_423q_min-support-gen440)
   (depends-on declare art423_qualified min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_423q_min] ) ) ) ?gen330 <- ( art423_qualified ( defendant ?Defendant ) ) ?gen331 <- ( min_imprisonment ( value 2 ) ( positive-support $?gen333 & : ( not ( subseq-pos ( create$ pen_423q_min ?gen330 $$$ $?gen333 ) ) ) ) ) ( test ( eq ( class ?gen331 ) min_imprisonment ) ) => ( calc ( bind $?gen336 ( create$ pen_423q_min ?gen330 $?gen333 ) ) ) ?gen331 <- ( min_imprisonment ( positive-support $?gen336 ) )"))

([pen_423b_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_423b_max-defeasibly-dot-gen442)
   (depends-on declare max_imprisonment art423_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_423b_max] ) ) ) ?gen322 <- ( max_imprisonment ( value 8 ) ( positive 1 ) ( positive-derivator pen_423b_max $? ) ) ( test ( eq ( class ?gen322 ) max_imprisonment ) ) ( not ( and ?gen329 <- ( art423_basic ( defendant ?Defendant ) ( positive ?gen328 & : ( >= ?gen328 1 ) ) ) ?gen322 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen324 & : ( not ( member$ pen_423b_max $?gen324 ) ) ) ) ) ) => ?gen322 <- ( max_imprisonment ( positive 0 ) )"))

([pen_423b_max-defeasibly] of derived-attribute-rule
   (pos-name pen_423b_max-defeasibly-gen444)
   (depends-on declare art423_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_423b_max] ) ) ) ?gen329 <- ( art423_basic ( defendant ?Defendant ) ( positive ?gen328 & : ( >= ?gen328 1 ) ) ) ?gen322 <- ( max_imprisonment ( value 8 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen324 & : ( not ( member$ pen_423b_max $?gen324 ) ) ) ) ( test ( eq ( class ?gen322 ) max_imprisonment ) ) => ?gen322 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_423b_max ?gen329 ) )"))

([pen_423b_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_423b_max-overruled-dot-gen446)
   (depends-on declare max_imprisonment art423_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_423b_max] ) ) ) ?gen322 <- ( max_imprisonment ( value 8 ) ( negative-support $?gen325 ) ( negative-overruled $?gen326 & : ( subseq-pos ( create$ pen_423b_max-overruled $?gen325 $$$ $?gen326 ) ) ) ) ( test ( eq ( class ?gen322 ) max_imprisonment ) ) ( not ( and ?gen329 <- ( art423_basic ( defendant ?Defendant ) ( positive ?gen328 & : ( >= ?gen328 1 ) ) ) ?gen322 <- ( max_imprisonment ( positive-defeated $?gen324 & : ( not ( member$ pen_423b_max $?gen324 ) ) ) ) ) ) => ( calc ( bind $?gen327 ( delete-member$ $?gen326 ( create$ pen_423b_max-overruled $?gen325 ) ) ) ) ?gen322 <- ( max_imprisonment ( negative-overruled $?gen327 ) )"))

([pen_423b_max-overruled] of derived-attribute-rule
   (pos-name pen_423b_max-overruled-gen448)
   (depends-on declare art423_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_423b_max] ) ) ) ?gen329 <- ( art423_basic ( defendant ?Defendant ) ( positive ?gen328 & : ( >= ?gen328 1 ) ) ) ?gen322 <- ( max_imprisonment ( value 8 ) ( negative-support $?gen325 ) ( negative-overruled $?gen326 & : ( not ( subseq-pos ( create$ pen_423b_max-overruled $?gen325 $$$ $?gen326 ) ) ) ) ( positive-defeated $?gen324 & : ( not ( member$ pen_423b_max $?gen324 ) ) ) ) ( test ( eq ( class ?gen322 ) max_imprisonment ) ) => ( calc ( bind $?gen327 ( create$ pen_423b_max-overruled $?gen325 $?gen326 ) ) ) ?gen322 <- ( max_imprisonment ( negative-overruled $?gen327 ) )"))

([pen_423b_max-support] of derived-attribute-rule
   (pos-name pen_423b_max-support-gen450)
   (depends-on declare art423_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_423b_max] ) ) ) ?gen321 <- ( art423_basic ( defendant ?Defendant ) ) ?gen322 <- ( max_imprisonment ( value 8 ) ( positive-support $?gen324 & : ( not ( subseq-pos ( create$ pen_423b_max ?gen321 $$$ $?gen324 ) ) ) ) ) ( test ( eq ( class ?gen322 ) max_imprisonment ) ) => ( calc ( bind $?gen327 ( create$ pen_423b_max ?gen321 $?gen324 ) ) ) ?gen322 <- ( max_imprisonment ( positive-support $?gen327 ) )"))

([pen_423b_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_423b_min-defeasibly-dot-gen452)
   (depends-on declare min_imprisonment art423_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_423b_min] ) ) ) ?gen313 <- ( min_imprisonment ( value 1 ) ( positive 1 ) ( positive-derivator pen_423b_min $? ) ) ( test ( eq ( class ?gen313 ) min_imprisonment ) ) ( not ( and ?gen320 <- ( art423_basic ( defendant ?Defendant ) ( positive ?gen319 & : ( >= ?gen319 1 ) ) ) ?gen313 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen315 & : ( not ( member$ pen_423b_min $?gen315 ) ) ) ) ) ) => ?gen313 <- ( min_imprisonment ( positive 0 ) )"))

([pen_423b_min-defeasibly] of derived-attribute-rule
   (pos-name pen_423b_min-defeasibly-gen454)
   (depends-on declare art423_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_423b_min] ) ) ) ?gen320 <- ( art423_basic ( defendant ?Defendant ) ( positive ?gen319 & : ( >= ?gen319 1 ) ) ) ?gen313 <- ( min_imprisonment ( value 1 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen315 & : ( not ( member$ pen_423b_min $?gen315 ) ) ) ) ( test ( eq ( class ?gen313 ) min_imprisonment ) ) => ?gen313 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_423b_min ?gen320 ) )"))

([pen_423b_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_423b_min-overruled-dot-gen456)
   (depends-on declare min_imprisonment art423_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_423b_min] ) ) ) ?gen313 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen316 ) ( negative-overruled $?gen317 & : ( subseq-pos ( create$ pen_423b_min-overruled $?gen316 $$$ $?gen317 ) ) ) ) ( test ( eq ( class ?gen313 ) min_imprisonment ) ) ( not ( and ?gen320 <- ( art423_basic ( defendant ?Defendant ) ( positive ?gen319 & : ( >= ?gen319 1 ) ) ) ?gen313 <- ( min_imprisonment ( positive-defeated $?gen315 & : ( not ( member$ pen_423b_min $?gen315 ) ) ) ) ) ) => ( calc ( bind $?gen318 ( delete-member$ $?gen317 ( create$ pen_423b_min-overruled $?gen316 ) ) ) ) ?gen313 <- ( min_imprisonment ( negative-overruled $?gen318 ) )"))

([pen_423b_min-overruled] of derived-attribute-rule
   (pos-name pen_423b_min-overruled-gen458)
   (depends-on declare art423_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_423b_min] ) ) ) ?gen320 <- ( art423_basic ( defendant ?Defendant ) ( positive ?gen319 & : ( >= ?gen319 1 ) ) ) ?gen313 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen316 ) ( negative-overruled $?gen317 & : ( not ( subseq-pos ( create$ pen_423b_min-overruled $?gen316 $$$ $?gen317 ) ) ) ) ( positive-defeated $?gen315 & : ( not ( member$ pen_423b_min $?gen315 ) ) ) ) ( test ( eq ( class ?gen313 ) min_imprisonment ) ) => ( calc ( bind $?gen318 ( create$ pen_423b_min-overruled $?gen316 $?gen317 ) ) ) ?gen313 <- ( min_imprisonment ( negative-overruled $?gen318 ) )"))

([pen_423b_min-support] of derived-attribute-rule
   (pos-name pen_423b_min-support-gen460)
   (depends-on declare art423_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_423b_min] ) ) ) ?gen312 <- ( art423_basic ( defendant ?Defendant ) ) ?gen313 <- ( min_imprisonment ( value 1 ) ( positive-support $?gen315 & : ( not ( subseq-pos ( create$ pen_423b_min ?gen312 $$$ $?gen315 ) ) ) ) ) ( test ( eq ( class ?gen313 ) min_imprisonment ) ) => ( calc ( bind $?gen318 ( create$ pen_423b_min ?gen312 $?gen315 ) ) ) ?gen313 <- ( min_imprisonment ( positive-support $?gen318 ) )"))

([pen_422org_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_422org_max-defeasibly-dot-gen462)
   (depends-on declare max_imprisonment art422_organized max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_422org_max] ) ) ) ?gen304 <- ( max_imprisonment ( value 8 ) ( positive 1 ) ( positive-derivator pen_422org_max $? ) ) ( test ( eq ( class ?gen304 ) max_imprisonment ) ) ( not ( and ?gen311 <- ( art422_organized ( defendant ?Defendant ) ( positive ?gen310 & : ( >= ?gen310 1 ) ) ) ?gen304 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen306 & : ( not ( member$ pen_422org_max $?gen306 ) ) ) ) ) ) => ?gen304 <- ( max_imprisonment ( positive 0 ) )"))

([pen_422org_max-defeasibly] of derived-attribute-rule
   (pos-name pen_422org_max-defeasibly-gen464)
   (depends-on declare art422_organized max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_422org_max] ) ) ) ?gen311 <- ( art422_organized ( defendant ?Defendant ) ( positive ?gen310 & : ( >= ?gen310 1 ) ) ) ?gen304 <- ( max_imprisonment ( value 8 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen306 & : ( not ( member$ pen_422org_max $?gen306 ) ) ) ) ( test ( eq ( class ?gen304 ) max_imprisonment ) ) => ?gen304 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_422org_max ?gen311 ) )"))

([pen_422org_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_422org_max-overruled-dot-gen466)
   (depends-on declare max_imprisonment art422_organized max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_422org_max] ) ) ) ?gen304 <- ( max_imprisonment ( value 8 ) ( negative-support $?gen307 ) ( negative-overruled $?gen308 & : ( subseq-pos ( create$ pen_422org_max-overruled $?gen307 $$$ $?gen308 ) ) ) ) ( test ( eq ( class ?gen304 ) max_imprisonment ) ) ( not ( and ?gen311 <- ( art422_organized ( defendant ?Defendant ) ( positive ?gen310 & : ( >= ?gen310 1 ) ) ) ?gen304 <- ( max_imprisonment ( positive-defeated $?gen306 & : ( not ( member$ pen_422org_max $?gen306 ) ) ) ) ) ) => ( calc ( bind $?gen309 ( delete-member$ $?gen308 ( create$ pen_422org_max-overruled $?gen307 ) ) ) ) ?gen304 <- ( max_imprisonment ( negative-overruled $?gen309 ) )"))

([pen_422org_max-overruled] of derived-attribute-rule
   (pos-name pen_422org_max-overruled-gen468)
   (depends-on declare art422_organized max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_422org_max] ) ) ) ?gen311 <- ( art422_organized ( defendant ?Defendant ) ( positive ?gen310 & : ( >= ?gen310 1 ) ) ) ?gen304 <- ( max_imprisonment ( value 8 ) ( negative-support $?gen307 ) ( negative-overruled $?gen308 & : ( not ( subseq-pos ( create$ pen_422org_max-overruled $?gen307 $$$ $?gen308 ) ) ) ) ( positive-defeated $?gen306 & : ( not ( member$ pen_422org_max $?gen306 ) ) ) ) ( test ( eq ( class ?gen304 ) max_imprisonment ) ) => ( calc ( bind $?gen309 ( create$ pen_422org_max-overruled $?gen307 $?gen308 ) ) ) ?gen304 <- ( max_imprisonment ( negative-overruled $?gen309 ) )"))

([pen_422org_max-support] of derived-attribute-rule
   (pos-name pen_422org_max-support-gen470)
   (depends-on declare art422_organized max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_422org_max] ) ) ) ?gen303 <- ( art422_organized ( defendant ?Defendant ) ) ?gen304 <- ( max_imprisonment ( value 8 ) ( positive-support $?gen306 & : ( not ( subseq-pos ( create$ pen_422org_max ?gen303 $$$ $?gen306 ) ) ) ) ) ( test ( eq ( class ?gen304 ) max_imprisonment ) ) => ( calc ( bind $?gen309 ( create$ pen_422org_max ?gen303 $?gen306 ) ) ) ?gen304 <- ( max_imprisonment ( positive-support $?gen309 ) )"))

([pen_422org_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_422org_min-defeasibly-dot-gen472)
   (depends-on declare min_imprisonment art422_organized min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_422org_min] ) ) ) ?gen295 <- ( min_imprisonment ( value 1 ) ( positive 1 ) ( positive-derivator pen_422org_min $? ) ) ( test ( eq ( class ?gen295 ) min_imprisonment ) ) ( not ( and ?gen302 <- ( art422_organized ( defendant ?Defendant ) ( positive ?gen301 & : ( >= ?gen301 1 ) ) ) ?gen295 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen297 & : ( not ( member$ pen_422org_min $?gen297 ) ) ) ) ) ) => ?gen295 <- ( min_imprisonment ( positive 0 ) )"))

([pen_422org_min-defeasibly] of derived-attribute-rule
   (pos-name pen_422org_min-defeasibly-gen474)
   (depends-on declare art422_organized min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_422org_min] ) ) ) ?gen302 <- ( art422_organized ( defendant ?Defendant ) ( positive ?gen301 & : ( >= ?gen301 1 ) ) ) ?gen295 <- ( min_imprisonment ( value 1 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen297 & : ( not ( member$ pen_422org_min $?gen297 ) ) ) ) ( test ( eq ( class ?gen295 ) min_imprisonment ) ) => ?gen295 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_422org_min ?gen302 ) )"))

([pen_422org_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_422org_min-overruled-dot-gen476)
   (depends-on declare min_imprisonment art422_organized min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_422org_min] ) ) ) ?gen295 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen298 ) ( negative-overruled $?gen299 & : ( subseq-pos ( create$ pen_422org_min-overruled $?gen298 $$$ $?gen299 ) ) ) ) ( test ( eq ( class ?gen295 ) min_imprisonment ) ) ( not ( and ?gen302 <- ( art422_organized ( defendant ?Defendant ) ( positive ?gen301 & : ( >= ?gen301 1 ) ) ) ?gen295 <- ( min_imprisonment ( positive-defeated $?gen297 & : ( not ( member$ pen_422org_min $?gen297 ) ) ) ) ) ) => ( calc ( bind $?gen300 ( delete-member$ $?gen299 ( create$ pen_422org_min-overruled $?gen298 ) ) ) ) ?gen295 <- ( min_imprisonment ( negative-overruled $?gen300 ) )"))

([pen_422org_min-overruled] of derived-attribute-rule
   (pos-name pen_422org_min-overruled-gen478)
   (depends-on declare art422_organized min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_422org_min] ) ) ) ?gen302 <- ( art422_organized ( defendant ?Defendant ) ( positive ?gen301 & : ( >= ?gen301 1 ) ) ) ?gen295 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen298 ) ( negative-overruled $?gen299 & : ( not ( subseq-pos ( create$ pen_422org_min-overruled $?gen298 $$$ $?gen299 ) ) ) ) ( positive-defeated $?gen297 & : ( not ( member$ pen_422org_min $?gen297 ) ) ) ) ( test ( eq ( class ?gen295 ) min_imprisonment ) ) => ( calc ( bind $?gen300 ( create$ pen_422org_min-overruled $?gen298 $?gen299 ) ) ) ?gen295 <- ( min_imprisonment ( negative-overruled $?gen300 ) )"))

([pen_422org_min-support] of derived-attribute-rule
   (pos-name pen_422org_min-support-gen480)
   (depends-on declare art422_organized min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_422org_min] ) ) ) ?gen294 <- ( art422_organized ( defendant ?Defendant ) ) ?gen295 <- ( min_imprisonment ( value 1 ) ( positive-support $?gen297 & : ( not ( subseq-pos ( create$ pen_422org_min ?gen294 $$$ $?gen297 ) ) ) ) ) ( test ( eq ( class ?gen295 ) min_imprisonment ) ) => ( calc ( bind $?gen300 ( create$ pen_422org_min ?gen294 $?gen297 ) ) ) ?gen295 <- ( min_imprisonment ( positive-support $?gen300 ) )"))

([pen_422b_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_422b_max-defeasibly-dot-gen482)
   (depends-on declare max_imprisonment art422_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_422b_max] ) ) ) ?gen286 <- ( max_imprisonment ( value 5 ) ( positive 1 ) ( positive-derivator pen_422b_max $? ) ) ( test ( eq ( class ?gen286 ) max_imprisonment ) ) ( not ( and ?gen293 <- ( art422_basic ( defendant ?Defendant ) ( positive ?gen292 & : ( >= ?gen292 1 ) ) ) ?gen286 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen288 & : ( not ( member$ pen_422b_max $?gen288 ) ) ) ) ) ) => ?gen286 <- ( max_imprisonment ( positive 0 ) )"))

([pen_422b_max-defeasibly] of derived-attribute-rule
   (pos-name pen_422b_max-defeasibly-gen484)
   (depends-on declare art422_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_422b_max] ) ) ) ?gen293 <- ( art422_basic ( defendant ?Defendant ) ( positive ?gen292 & : ( >= ?gen292 1 ) ) ) ?gen286 <- ( max_imprisonment ( value 5 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen288 & : ( not ( member$ pen_422b_max $?gen288 ) ) ) ) ( test ( eq ( class ?gen286 ) max_imprisonment ) ) => ?gen286 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_422b_max ?gen293 ) )"))

([pen_422b_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_422b_max-overruled-dot-gen486)
   (depends-on declare max_imprisonment art422_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_422b_max] ) ) ) ?gen286 <- ( max_imprisonment ( value 5 ) ( negative-support $?gen289 ) ( negative-overruled $?gen290 & : ( subseq-pos ( create$ pen_422b_max-overruled $?gen289 $$$ $?gen290 ) ) ) ) ( test ( eq ( class ?gen286 ) max_imprisonment ) ) ( not ( and ?gen293 <- ( art422_basic ( defendant ?Defendant ) ( positive ?gen292 & : ( >= ?gen292 1 ) ) ) ?gen286 <- ( max_imprisonment ( positive-defeated $?gen288 & : ( not ( member$ pen_422b_max $?gen288 ) ) ) ) ) ) => ( calc ( bind $?gen291 ( delete-member$ $?gen290 ( create$ pen_422b_max-overruled $?gen289 ) ) ) ) ?gen286 <- ( max_imprisonment ( negative-overruled $?gen291 ) )"))

([pen_422b_max-overruled] of derived-attribute-rule
   (pos-name pen_422b_max-overruled-gen488)
   (depends-on declare art422_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_422b_max] ) ) ) ?gen293 <- ( art422_basic ( defendant ?Defendant ) ( positive ?gen292 & : ( >= ?gen292 1 ) ) ) ?gen286 <- ( max_imprisonment ( value 5 ) ( negative-support $?gen289 ) ( negative-overruled $?gen290 & : ( not ( subseq-pos ( create$ pen_422b_max-overruled $?gen289 $$$ $?gen290 ) ) ) ) ( positive-defeated $?gen288 & : ( not ( member$ pen_422b_max $?gen288 ) ) ) ) ( test ( eq ( class ?gen286 ) max_imprisonment ) ) => ( calc ( bind $?gen291 ( create$ pen_422b_max-overruled $?gen289 $?gen290 ) ) ) ?gen286 <- ( max_imprisonment ( negative-overruled $?gen291 ) )"))

([pen_422b_max-support] of derived-attribute-rule
   (pos-name pen_422b_max-support-gen490)
   (depends-on declare art422_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_422b_max] ) ) ) ?gen285 <- ( art422_basic ( defendant ?Defendant ) ) ?gen286 <- ( max_imprisonment ( value 5 ) ( positive-support $?gen288 & : ( not ( subseq-pos ( create$ pen_422b_max ?gen285 $$$ $?gen288 ) ) ) ) ) ( test ( eq ( class ?gen286 ) max_imprisonment ) ) => ( calc ( bind $?gen291 ( create$ pen_422b_max ?gen285 $?gen288 ) ) ) ?gen286 <- ( max_imprisonment ( positive-support $?gen291 ) )"))

([pen_422b_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_422b_min-defeasibly-dot-gen492)
   (depends-on declare min_imprisonment art422_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_422b_min] ) ) ) ?gen277 <- ( min_imprisonment ( value 1 ) ( positive 1 ) ( positive-derivator pen_422b_min $? ) ) ( test ( eq ( class ?gen277 ) min_imprisonment ) ) ( not ( and ?gen284 <- ( art422_basic ( defendant ?Defendant ) ( positive ?gen283 & : ( >= ?gen283 1 ) ) ) ?gen277 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen279 & : ( not ( member$ pen_422b_min $?gen279 ) ) ) ) ) ) => ?gen277 <- ( min_imprisonment ( positive 0 ) )"))

([pen_422b_min-defeasibly] of derived-attribute-rule
   (pos-name pen_422b_min-defeasibly-gen494)
   (depends-on declare art422_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_422b_min] ) ) ) ?gen284 <- ( art422_basic ( defendant ?Defendant ) ( positive ?gen283 & : ( >= ?gen283 1 ) ) ) ?gen277 <- ( min_imprisonment ( value 1 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen279 & : ( not ( member$ pen_422b_min $?gen279 ) ) ) ) ( test ( eq ( class ?gen277 ) min_imprisonment ) ) => ?gen277 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_422b_min ?gen284 ) )"))

([pen_422b_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_422b_min-overruled-dot-gen496)
   (depends-on declare min_imprisonment art422_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_422b_min] ) ) ) ?gen277 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen280 ) ( negative-overruled $?gen281 & : ( subseq-pos ( create$ pen_422b_min-overruled $?gen280 $$$ $?gen281 ) ) ) ) ( test ( eq ( class ?gen277 ) min_imprisonment ) ) ( not ( and ?gen284 <- ( art422_basic ( defendant ?Defendant ) ( positive ?gen283 & : ( >= ?gen283 1 ) ) ) ?gen277 <- ( min_imprisonment ( positive-defeated $?gen279 & : ( not ( member$ pen_422b_min $?gen279 ) ) ) ) ) ) => ( calc ( bind $?gen282 ( delete-member$ $?gen281 ( create$ pen_422b_min-overruled $?gen280 ) ) ) ) ?gen277 <- ( min_imprisonment ( negative-overruled $?gen282 ) )"))

([pen_422b_min-overruled] of derived-attribute-rule
   (pos-name pen_422b_min-overruled-gen498)
   (depends-on declare art422_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_422b_min] ) ) ) ?gen284 <- ( art422_basic ( defendant ?Defendant ) ( positive ?gen283 & : ( >= ?gen283 1 ) ) ) ?gen277 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen280 ) ( negative-overruled $?gen281 & : ( not ( subseq-pos ( create$ pen_422b_min-overruled $?gen280 $$$ $?gen281 ) ) ) ) ( positive-defeated $?gen279 & : ( not ( member$ pen_422b_min $?gen279 ) ) ) ) ( test ( eq ( class ?gen277 ) min_imprisonment ) ) => ( calc ( bind $?gen282 ( create$ pen_422b_min-overruled $?gen280 $?gen281 ) ) ) ?gen277 <- ( min_imprisonment ( negative-overruled $?gen282 ) )"))

([pen_422b_min-support] of derived-attribute-rule
   (pos-name pen_422b_min-support-gen500)
   (depends-on declare art422_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_422b_min] ) ) ) ?gen276 <- ( art422_basic ( defendant ?Defendant ) ) ?gen277 <- ( min_imprisonment ( value 1 ) ( positive-support $?gen279 & : ( not ( subseq-pos ( create$ pen_422b_min ?gen276 $$$ $?gen279 ) ) ) ) ) ( test ( eq ( class ?gen277 ) min_imprisonment ) ) => ( calc ( bind $?gen282 ( create$ pen_422b_min ?gen276 $?gen279 ) ) ) ?gen277 <- ( min_imprisonment ( positive-support $?gen282 ) )"))

([pen_420q_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_420q_max-defeasibly-dot-gen502)
   (depends-on declare max_imprisonment art420_qualified max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_420q_max] ) ) ) ?gen268 <- ( max_imprisonment ( value 10 ) ( positive 1 ) ( positive-derivator pen_420q_max $? ) ) ( test ( eq ( class ?gen268 ) max_imprisonment ) ) ( not ( and ?gen275 <- ( art420_qualified ( defendant ?Defendant ) ( positive ?gen274 & : ( >= ?gen274 1 ) ) ) ?gen268 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen270 & : ( not ( member$ pen_420q_max $?gen270 ) ) ) ) ) ) => ?gen268 <- ( max_imprisonment ( positive 0 ) )"))

([pen_420q_max-defeasibly] of derived-attribute-rule
   (pos-name pen_420q_max-defeasibly-gen504)
   (depends-on declare art420_qualified max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_420q_max] ) ) ) ?gen275 <- ( art420_qualified ( defendant ?Defendant ) ( positive ?gen274 & : ( >= ?gen274 1 ) ) ) ?gen268 <- ( max_imprisonment ( value 10 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen270 & : ( not ( member$ pen_420q_max $?gen270 ) ) ) ) ( test ( eq ( class ?gen268 ) max_imprisonment ) ) => ?gen268 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_420q_max ?gen275 ) )"))

([pen_420q_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_420q_max-overruled-dot-gen506)
   (depends-on declare max_imprisonment art420_qualified max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_420q_max] ) ) ) ?gen268 <- ( max_imprisonment ( value 10 ) ( negative-support $?gen271 ) ( negative-overruled $?gen272 & : ( subseq-pos ( create$ pen_420q_max-overruled $?gen271 $$$ $?gen272 ) ) ) ) ( test ( eq ( class ?gen268 ) max_imprisonment ) ) ( not ( and ?gen275 <- ( art420_qualified ( defendant ?Defendant ) ( positive ?gen274 & : ( >= ?gen274 1 ) ) ) ?gen268 <- ( max_imprisonment ( positive-defeated $?gen270 & : ( not ( member$ pen_420q_max $?gen270 ) ) ) ) ) ) => ( calc ( bind $?gen273 ( delete-member$ $?gen272 ( create$ pen_420q_max-overruled $?gen271 ) ) ) ) ?gen268 <- ( max_imprisonment ( negative-overruled $?gen273 ) )"))

([pen_420q_max-overruled] of derived-attribute-rule
   (pos-name pen_420q_max-overruled-gen508)
   (depends-on declare art420_qualified max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_420q_max] ) ) ) ?gen275 <- ( art420_qualified ( defendant ?Defendant ) ( positive ?gen274 & : ( >= ?gen274 1 ) ) ) ?gen268 <- ( max_imprisonment ( value 10 ) ( negative-support $?gen271 ) ( negative-overruled $?gen272 & : ( not ( subseq-pos ( create$ pen_420q_max-overruled $?gen271 $$$ $?gen272 ) ) ) ) ( positive-defeated $?gen270 & : ( not ( member$ pen_420q_max $?gen270 ) ) ) ) ( test ( eq ( class ?gen268 ) max_imprisonment ) ) => ( calc ( bind $?gen273 ( create$ pen_420q_max-overruled $?gen271 $?gen272 ) ) ) ?gen268 <- ( max_imprisonment ( negative-overruled $?gen273 ) )"))

([pen_420q_max-support] of derived-attribute-rule
   (pos-name pen_420q_max-support-gen510)
   (depends-on declare art420_qualified max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_420q_max] ) ) ) ?gen267 <- ( art420_qualified ( defendant ?Defendant ) ) ?gen268 <- ( max_imprisonment ( value 10 ) ( positive-support $?gen270 & : ( not ( subseq-pos ( create$ pen_420q_max ?gen267 $$$ $?gen270 ) ) ) ) ) ( test ( eq ( class ?gen268 ) max_imprisonment ) ) => ( calc ( bind $?gen273 ( create$ pen_420q_max ?gen267 $?gen270 ) ) ) ?gen268 <- ( max_imprisonment ( positive-support $?gen273 ) )"))

([pen_420q_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_420q_min-defeasibly-dot-gen512)
   (depends-on declare min_imprisonment art420_qualified min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_420q_min] ) ) ) ?gen259 <- ( min_imprisonment ( value 2 ) ( positive 1 ) ( positive-derivator pen_420q_min $? ) ) ( test ( eq ( class ?gen259 ) min_imprisonment ) ) ( not ( and ?gen266 <- ( art420_qualified ( defendant ?Defendant ) ( positive ?gen265 & : ( >= ?gen265 1 ) ) ) ?gen259 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen261 & : ( not ( member$ pen_420q_min $?gen261 ) ) ) ) ) ) => ?gen259 <- ( min_imprisonment ( positive 0 ) )"))

([pen_420q_min-defeasibly] of derived-attribute-rule
   (pos-name pen_420q_min-defeasibly-gen514)
   (depends-on declare art420_qualified min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_420q_min] ) ) ) ?gen266 <- ( art420_qualified ( defendant ?Defendant ) ( positive ?gen265 & : ( >= ?gen265 1 ) ) ) ?gen259 <- ( min_imprisonment ( value 2 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen261 & : ( not ( member$ pen_420q_min $?gen261 ) ) ) ) ( test ( eq ( class ?gen259 ) min_imprisonment ) ) => ?gen259 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_420q_min ?gen266 ) )"))

([pen_420q_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_420q_min-overruled-dot-gen516)
   (depends-on declare min_imprisonment art420_qualified min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_420q_min] ) ) ) ?gen259 <- ( min_imprisonment ( value 2 ) ( negative-support $?gen262 ) ( negative-overruled $?gen263 & : ( subseq-pos ( create$ pen_420q_min-overruled $?gen262 $$$ $?gen263 ) ) ) ) ( test ( eq ( class ?gen259 ) min_imprisonment ) ) ( not ( and ?gen266 <- ( art420_qualified ( defendant ?Defendant ) ( positive ?gen265 & : ( >= ?gen265 1 ) ) ) ?gen259 <- ( min_imprisonment ( positive-defeated $?gen261 & : ( not ( member$ pen_420q_min $?gen261 ) ) ) ) ) ) => ( calc ( bind $?gen264 ( delete-member$ $?gen263 ( create$ pen_420q_min-overruled $?gen262 ) ) ) ) ?gen259 <- ( min_imprisonment ( negative-overruled $?gen264 ) )"))

([pen_420q_min-overruled] of derived-attribute-rule
   (pos-name pen_420q_min-overruled-gen518)
   (depends-on declare art420_qualified min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_420q_min] ) ) ) ?gen266 <- ( art420_qualified ( defendant ?Defendant ) ( positive ?gen265 & : ( >= ?gen265 1 ) ) ) ?gen259 <- ( min_imprisonment ( value 2 ) ( negative-support $?gen262 ) ( negative-overruled $?gen263 & : ( not ( subseq-pos ( create$ pen_420q_min-overruled $?gen262 $$$ $?gen263 ) ) ) ) ( positive-defeated $?gen261 & : ( not ( member$ pen_420q_min $?gen261 ) ) ) ) ( test ( eq ( class ?gen259 ) min_imprisonment ) ) => ( calc ( bind $?gen264 ( create$ pen_420q_min-overruled $?gen262 $?gen263 ) ) ) ?gen259 <- ( min_imprisonment ( negative-overruled $?gen264 ) )"))

([pen_420q_min-support] of derived-attribute-rule
   (pos-name pen_420q_min-support-gen520)
   (depends-on declare art420_qualified min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_420q_min] ) ) ) ?gen258 <- ( art420_qualified ( defendant ?Defendant ) ) ?gen259 <- ( min_imprisonment ( value 2 ) ( positive-support $?gen261 & : ( not ( subseq-pos ( create$ pen_420q_min ?gen258 $$$ $?gen261 ) ) ) ) ) ( test ( eq ( class ?gen259 ) min_imprisonment ) ) => ( calc ( bind $?gen264 ( create$ pen_420q_min ?gen258 $?gen261 ) ) ) ?gen259 <- ( min_imprisonment ( positive-support $?gen264 ) )"))

([pen_420b_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_420b_max-defeasibly-dot-gen522)
   (depends-on declare max_imprisonment art420_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_420b_max] ) ) ) ?gen250 <- ( max_imprisonment ( value 8 ) ( positive 1 ) ( positive-derivator pen_420b_max $? ) ) ( test ( eq ( class ?gen250 ) max_imprisonment ) ) ( not ( and ?gen257 <- ( art420_basic ( defendant ?Defendant ) ( positive ?gen256 & : ( >= ?gen256 1 ) ) ) ?gen250 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen252 & : ( not ( member$ pen_420b_max $?gen252 ) ) ) ) ) ) => ?gen250 <- ( max_imprisonment ( positive 0 ) )"))

([pen_420b_max-defeasibly] of derived-attribute-rule
   (pos-name pen_420b_max-defeasibly-gen524)
   (depends-on declare art420_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_420b_max] ) ) ) ?gen257 <- ( art420_basic ( defendant ?Defendant ) ( positive ?gen256 & : ( >= ?gen256 1 ) ) ) ?gen250 <- ( max_imprisonment ( value 8 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen252 & : ( not ( member$ pen_420b_max $?gen252 ) ) ) ) ( test ( eq ( class ?gen250 ) max_imprisonment ) ) => ?gen250 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_420b_max ?gen257 ) )"))

([pen_420b_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_420b_max-overruled-dot-gen526)
   (depends-on declare max_imprisonment art420_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_420b_max] ) ) ) ?gen250 <- ( max_imprisonment ( value 8 ) ( negative-support $?gen253 ) ( negative-overruled $?gen254 & : ( subseq-pos ( create$ pen_420b_max-overruled $?gen253 $$$ $?gen254 ) ) ) ) ( test ( eq ( class ?gen250 ) max_imprisonment ) ) ( not ( and ?gen257 <- ( art420_basic ( defendant ?Defendant ) ( positive ?gen256 & : ( >= ?gen256 1 ) ) ) ?gen250 <- ( max_imprisonment ( positive-defeated $?gen252 & : ( not ( member$ pen_420b_max $?gen252 ) ) ) ) ) ) => ( calc ( bind $?gen255 ( delete-member$ $?gen254 ( create$ pen_420b_max-overruled $?gen253 ) ) ) ) ?gen250 <- ( max_imprisonment ( negative-overruled $?gen255 ) )"))

([pen_420b_max-overruled] of derived-attribute-rule
   (pos-name pen_420b_max-overruled-gen528)
   (depends-on declare art420_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_420b_max] ) ) ) ?gen257 <- ( art420_basic ( defendant ?Defendant ) ( positive ?gen256 & : ( >= ?gen256 1 ) ) ) ?gen250 <- ( max_imprisonment ( value 8 ) ( negative-support $?gen253 ) ( negative-overruled $?gen254 & : ( not ( subseq-pos ( create$ pen_420b_max-overruled $?gen253 $$$ $?gen254 ) ) ) ) ( positive-defeated $?gen252 & : ( not ( member$ pen_420b_max $?gen252 ) ) ) ) ( test ( eq ( class ?gen250 ) max_imprisonment ) ) => ( calc ( bind $?gen255 ( create$ pen_420b_max-overruled $?gen253 $?gen254 ) ) ) ?gen250 <- ( max_imprisonment ( negative-overruled $?gen255 ) )"))

([pen_420b_max-support] of derived-attribute-rule
   (pos-name pen_420b_max-support-gen530)
   (depends-on declare art420_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_420b_max] ) ) ) ?gen249 <- ( art420_basic ( defendant ?Defendant ) ) ?gen250 <- ( max_imprisonment ( value 8 ) ( positive-support $?gen252 & : ( not ( subseq-pos ( create$ pen_420b_max ?gen249 $$$ $?gen252 ) ) ) ) ) ( test ( eq ( class ?gen250 ) max_imprisonment ) ) => ( calc ( bind $?gen255 ( create$ pen_420b_max ?gen249 $?gen252 ) ) ) ?gen250 <- ( max_imprisonment ( positive-support $?gen255 ) )"))

([pen_420b_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_420b_min-defeasibly-dot-gen532)
   (depends-on declare min_imprisonment art420_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_420b_min] ) ) ) ?gen241 <- ( min_imprisonment ( value 1 ) ( positive 1 ) ( positive-derivator pen_420b_min $? ) ) ( test ( eq ( class ?gen241 ) min_imprisonment ) ) ( not ( and ?gen248 <- ( art420_basic ( defendant ?Defendant ) ( positive ?gen247 & : ( >= ?gen247 1 ) ) ) ?gen241 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen243 & : ( not ( member$ pen_420b_min $?gen243 ) ) ) ) ) ) => ?gen241 <- ( min_imprisonment ( positive 0 ) )"))

([pen_420b_min-defeasibly] of derived-attribute-rule
   (pos-name pen_420b_min-defeasibly-gen534)
   (depends-on declare art420_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_420b_min] ) ) ) ?gen248 <- ( art420_basic ( defendant ?Defendant ) ( positive ?gen247 & : ( >= ?gen247 1 ) ) ) ?gen241 <- ( min_imprisonment ( value 1 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen243 & : ( not ( member$ pen_420b_min $?gen243 ) ) ) ) ( test ( eq ( class ?gen241 ) min_imprisonment ) ) => ?gen241 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_420b_min ?gen248 ) )"))

([pen_420b_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_420b_min-overruled-dot-gen536)
   (depends-on declare min_imprisonment art420_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_420b_min] ) ) ) ?gen241 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen244 ) ( negative-overruled $?gen245 & : ( subseq-pos ( create$ pen_420b_min-overruled $?gen244 $$$ $?gen245 ) ) ) ) ( test ( eq ( class ?gen241 ) min_imprisonment ) ) ( not ( and ?gen248 <- ( art420_basic ( defendant ?Defendant ) ( positive ?gen247 & : ( >= ?gen247 1 ) ) ) ?gen241 <- ( min_imprisonment ( positive-defeated $?gen243 & : ( not ( member$ pen_420b_min $?gen243 ) ) ) ) ) ) => ( calc ( bind $?gen246 ( delete-member$ $?gen245 ( create$ pen_420b_min-overruled $?gen244 ) ) ) ) ?gen241 <- ( min_imprisonment ( negative-overruled $?gen246 ) )"))

([pen_420b_min-overruled] of derived-attribute-rule
   (pos-name pen_420b_min-overruled-gen538)
   (depends-on declare art420_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_420b_min] ) ) ) ?gen248 <- ( art420_basic ( defendant ?Defendant ) ( positive ?gen247 & : ( >= ?gen247 1 ) ) ) ?gen241 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen244 ) ( negative-overruled $?gen245 & : ( not ( subseq-pos ( create$ pen_420b_min-overruled $?gen244 $$$ $?gen245 ) ) ) ) ( positive-defeated $?gen243 & : ( not ( member$ pen_420b_min $?gen243 ) ) ) ) ( test ( eq ( class ?gen241 ) min_imprisonment ) ) => ( calc ( bind $?gen246 ( create$ pen_420b_min-overruled $?gen244 $?gen245 ) ) ) ?gen241 <- ( min_imprisonment ( negative-overruled $?gen246 ) )"))

([pen_420b_min-support] of derived-attribute-rule
   (pos-name pen_420b_min-support-gen540)
   (depends-on declare art420_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_420b_min] ) ) ) ?gen240 <- ( art420_basic ( defendant ?Defendant ) ) ?gen241 <- ( min_imprisonment ( value 1 ) ( positive-support $?gen243 & : ( not ( subseq-pos ( create$ pen_420b_min ?gen240 $$$ $?gen243 ) ) ) ) ) ( test ( eq ( class ?gen241 ) min_imprisonment ) ) => ( calc ( bind $?gen246 ( create$ pen_420b_min ?gen240 $?gen243 ) ) ) ?gen241 <- ( min_imprisonment ( positive-support $?gen246 ) )"))

([pen_416org_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_416org_max-defeasibly-dot-gen542)
   (depends-on declare max_imprisonment art416_organized max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_416org_max] ) ) ) ?gen232 <- ( max_imprisonment ( value 12 ) ( positive 1 ) ( positive-derivator pen_416org_max $? ) ) ( test ( eq ( class ?gen232 ) max_imprisonment ) ) ( not ( and ?gen239 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen238 & : ( >= ?gen238 1 ) ) ) ?gen232 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen234 & : ( not ( member$ pen_416org_max $?gen234 ) ) ) ) ) ) => ?gen232 <- ( max_imprisonment ( positive 0 ) )"))

([pen_416org_max-defeasibly] of derived-attribute-rule
   (pos-name pen_416org_max-defeasibly-gen544)
   (depends-on declare art416_organized max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_416org_max] ) ) ) ?gen239 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen238 & : ( >= ?gen238 1 ) ) ) ?gen232 <- ( max_imprisonment ( value 12 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen234 & : ( not ( member$ pen_416org_max $?gen234 ) ) ) ) ( test ( eq ( class ?gen232 ) max_imprisonment ) ) => ?gen232 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_416org_max ?gen239 ) )"))

([pen_416org_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_416org_max-overruled-dot-gen546)
   (depends-on declare max_imprisonment art416_organized max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_416org_max] ) ) ) ?gen232 <- ( max_imprisonment ( value 12 ) ( negative-support $?gen235 ) ( negative-overruled $?gen236 & : ( subseq-pos ( create$ pen_416org_max-overruled $?gen235 $$$ $?gen236 ) ) ) ) ( test ( eq ( class ?gen232 ) max_imprisonment ) ) ( not ( and ?gen239 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen238 & : ( >= ?gen238 1 ) ) ) ?gen232 <- ( max_imprisonment ( positive-defeated $?gen234 & : ( not ( member$ pen_416org_max $?gen234 ) ) ) ) ) ) => ( calc ( bind $?gen237 ( delete-member$ $?gen236 ( create$ pen_416org_max-overruled $?gen235 ) ) ) ) ?gen232 <- ( max_imprisonment ( negative-overruled $?gen237 ) )"))

([pen_416org_max-overruled] of derived-attribute-rule
   (pos-name pen_416org_max-overruled-gen548)
   (depends-on declare art416_organized max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_416org_max] ) ) ) ?gen239 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen238 & : ( >= ?gen238 1 ) ) ) ?gen232 <- ( max_imprisonment ( value 12 ) ( negative-support $?gen235 ) ( negative-overruled $?gen236 & : ( not ( subseq-pos ( create$ pen_416org_max-overruled $?gen235 $$$ $?gen236 ) ) ) ) ( positive-defeated $?gen234 & : ( not ( member$ pen_416org_max $?gen234 ) ) ) ) ( test ( eq ( class ?gen232 ) max_imprisonment ) ) => ( calc ( bind $?gen237 ( create$ pen_416org_max-overruled $?gen235 $?gen236 ) ) ) ?gen232 <- ( max_imprisonment ( negative-overruled $?gen237 ) )"))

([pen_416org_max-support] of derived-attribute-rule
   (pos-name pen_416org_max-support-gen550)
   (depends-on declare art416_organized max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_416org_max] ) ) ) ?gen231 <- ( art416_organized ( defendant ?Defendant ) ) ?gen232 <- ( max_imprisonment ( value 12 ) ( positive-support $?gen234 & : ( not ( subseq-pos ( create$ pen_416org_max ?gen231 $$$ $?gen234 ) ) ) ) ) ( test ( eq ( class ?gen232 ) max_imprisonment ) ) => ( calc ( bind $?gen237 ( create$ pen_416org_max ?gen231 $?gen234 ) ) ) ?gen232 <- ( max_imprisonment ( positive-support $?gen237 ) )"))

([pen_416org_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_416org_min-defeasibly-dot-gen552)
   (depends-on declare min_imprisonment art416_organized min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_416org_min] ) ) ) ?gen223 <- ( min_imprisonment ( value 2 ) ( positive 1 ) ( positive-derivator pen_416org_min $? ) ) ( test ( eq ( class ?gen223 ) min_imprisonment ) ) ( not ( and ?gen230 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen229 & : ( >= ?gen229 1 ) ) ) ?gen223 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen225 & : ( not ( member$ pen_416org_min $?gen225 ) ) ) ) ) ) => ?gen223 <- ( min_imprisonment ( positive 0 ) )"))

([pen_416org_min-defeasibly] of derived-attribute-rule
   (pos-name pen_416org_min-defeasibly-gen554)
   (depends-on declare art416_organized min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_416org_min] ) ) ) ?gen230 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen229 & : ( >= ?gen229 1 ) ) ) ?gen223 <- ( min_imprisonment ( value 2 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen225 & : ( not ( member$ pen_416org_min $?gen225 ) ) ) ) ( test ( eq ( class ?gen223 ) min_imprisonment ) ) => ?gen223 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_416org_min ?gen230 ) )"))

([pen_416org_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_416org_min-overruled-dot-gen556)
   (depends-on declare min_imprisonment art416_organized min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_416org_min] ) ) ) ?gen223 <- ( min_imprisonment ( value 2 ) ( negative-support $?gen226 ) ( negative-overruled $?gen227 & : ( subseq-pos ( create$ pen_416org_min-overruled $?gen226 $$$ $?gen227 ) ) ) ) ( test ( eq ( class ?gen223 ) min_imprisonment ) ) ( not ( and ?gen230 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen229 & : ( >= ?gen229 1 ) ) ) ?gen223 <- ( min_imprisonment ( positive-defeated $?gen225 & : ( not ( member$ pen_416org_min $?gen225 ) ) ) ) ) ) => ( calc ( bind $?gen228 ( delete-member$ $?gen227 ( create$ pen_416org_min-overruled $?gen226 ) ) ) ) ?gen223 <- ( min_imprisonment ( negative-overruled $?gen228 ) )"))

([pen_416org_min-overruled] of derived-attribute-rule
   (pos-name pen_416org_min-overruled-gen558)
   (depends-on declare art416_organized min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_416org_min] ) ) ) ?gen230 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen229 & : ( >= ?gen229 1 ) ) ) ?gen223 <- ( min_imprisonment ( value 2 ) ( negative-support $?gen226 ) ( negative-overruled $?gen227 & : ( not ( subseq-pos ( create$ pen_416org_min-overruled $?gen226 $$$ $?gen227 ) ) ) ) ( positive-defeated $?gen225 & : ( not ( member$ pen_416org_min $?gen225 ) ) ) ) ( test ( eq ( class ?gen223 ) min_imprisonment ) ) => ( calc ( bind $?gen228 ( create$ pen_416org_min-overruled $?gen226 $?gen227 ) ) ) ?gen223 <- ( min_imprisonment ( negative-overruled $?gen228 ) )"))

([pen_416org_min-support] of derived-attribute-rule
   (pos-name pen_416org_min-support-gen560)
   (depends-on declare art416_organized min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_416org_min] ) ) ) ?gen222 <- ( art416_organized ( defendant ?Defendant ) ) ?gen223 <- ( min_imprisonment ( value 2 ) ( positive-support $?gen225 & : ( not ( subseq-pos ( create$ pen_416org_min ?gen222 $$$ $?gen225 ) ) ) ) ) ( test ( eq ( class ?gen223 ) min_imprisonment ) ) => ( calc ( bind $?gen228 ( create$ pen_416org_min ?gen222 $?gen225 ) ) ) ?gen223 <- ( min_imprisonment ( positive-support $?gen228 ) )"))

([pen_416qg_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_416qg_max-defeasibly-dot-gen562)
   (depends-on declare max_imprisonment art416_qualified_gain max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_416qg_max] ) ) ) ?gen214 <- ( max_imprisonment ( value 10 ) ( positive 1 ) ( positive-derivator pen_416qg_max $? ) ) ( test ( eq ( class ?gen214 ) max_imprisonment ) ) ( not ( and ?gen221 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive ?gen220 & : ( >= ?gen220 1 ) ) ) ?gen214 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen216 & : ( not ( member$ pen_416qg_max $?gen216 ) ) ) ) ) ) => ?gen214 <- ( max_imprisonment ( positive 0 ) )"))

([pen_416qg_max-defeasibly] of derived-attribute-rule
   (pos-name pen_416qg_max-defeasibly-gen564)
   (depends-on declare art416_qualified_gain max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_416qg_max] ) ) ) ?gen221 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive ?gen220 & : ( >= ?gen220 1 ) ) ) ?gen214 <- ( max_imprisonment ( value 10 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen216 & : ( not ( member$ pen_416qg_max $?gen216 ) ) ) ) ( test ( eq ( class ?gen214 ) max_imprisonment ) ) => ?gen214 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_416qg_max ?gen221 ) )"))

([pen_416qg_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_416qg_max-overruled-dot-gen566)
   (depends-on declare max_imprisonment art416_qualified_gain max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_416qg_max] ) ) ) ?gen214 <- ( max_imprisonment ( value 10 ) ( negative-support $?gen217 ) ( negative-overruled $?gen218 & : ( subseq-pos ( create$ pen_416qg_max-overruled $?gen217 $$$ $?gen218 ) ) ) ) ( test ( eq ( class ?gen214 ) max_imprisonment ) ) ( not ( and ?gen221 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive ?gen220 & : ( >= ?gen220 1 ) ) ) ?gen214 <- ( max_imprisonment ( positive-defeated $?gen216 & : ( not ( member$ pen_416qg_max $?gen216 ) ) ) ) ) ) => ( calc ( bind $?gen219 ( delete-member$ $?gen218 ( create$ pen_416qg_max-overruled $?gen217 ) ) ) ) ?gen214 <- ( max_imprisonment ( negative-overruled $?gen219 ) )"))

([pen_416qg_max-overruled] of derived-attribute-rule
   (pos-name pen_416qg_max-overruled-gen568)
   (depends-on declare art416_qualified_gain max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_416qg_max] ) ) ) ?gen221 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive ?gen220 & : ( >= ?gen220 1 ) ) ) ?gen214 <- ( max_imprisonment ( value 10 ) ( negative-support $?gen217 ) ( negative-overruled $?gen218 & : ( not ( subseq-pos ( create$ pen_416qg_max-overruled $?gen217 $$$ $?gen218 ) ) ) ) ( positive-defeated $?gen216 & : ( not ( member$ pen_416qg_max $?gen216 ) ) ) ) ( test ( eq ( class ?gen214 ) max_imprisonment ) ) => ( calc ( bind $?gen219 ( create$ pen_416qg_max-overruled $?gen217 $?gen218 ) ) ) ?gen214 <- ( max_imprisonment ( negative-overruled $?gen219 ) )"))

([pen_416qg_max-support] of derived-attribute-rule
   (pos-name pen_416qg_max-support-gen570)
   (depends-on declare art416_qualified_gain max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_416qg_max] ) ) ) ?gen213 <- ( art416_qualified_gain ( defendant ?Defendant ) ) ?gen214 <- ( max_imprisonment ( value 10 ) ( positive-support $?gen216 & : ( not ( subseq-pos ( create$ pen_416qg_max ?gen213 $$$ $?gen216 ) ) ) ) ) ( test ( eq ( class ?gen214 ) max_imprisonment ) ) => ( calc ( bind $?gen219 ( create$ pen_416qg_max ?gen213 $?gen216 ) ) ) ?gen214 <- ( max_imprisonment ( positive-support $?gen219 ) )"))

([pen_416qg_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_416qg_min-defeasibly-dot-gen572)
   (depends-on declare min_imprisonment art416_qualified_gain min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_416qg_min] ) ) ) ?gen205 <- ( min_imprisonment ( value 1 ) ( positive 1 ) ( positive-derivator pen_416qg_min $? ) ) ( test ( eq ( class ?gen205 ) min_imprisonment ) ) ( not ( and ?gen212 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive ?gen211 & : ( >= ?gen211 1 ) ) ) ?gen205 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen207 & : ( not ( member$ pen_416qg_min $?gen207 ) ) ) ) ) ) => ?gen205 <- ( min_imprisonment ( positive 0 ) )"))

([pen_416qg_min-defeasibly] of derived-attribute-rule
   (pos-name pen_416qg_min-defeasibly-gen574)
   (depends-on declare art416_qualified_gain min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_416qg_min] ) ) ) ?gen212 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive ?gen211 & : ( >= ?gen211 1 ) ) ) ?gen205 <- ( min_imprisonment ( value 1 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen207 & : ( not ( member$ pen_416qg_min $?gen207 ) ) ) ) ( test ( eq ( class ?gen205 ) min_imprisonment ) ) => ?gen205 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_416qg_min ?gen212 ) )"))

([pen_416qg_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_416qg_min-overruled-dot-gen576)
   (depends-on declare min_imprisonment art416_qualified_gain min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_416qg_min] ) ) ) ?gen205 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen208 ) ( negative-overruled $?gen209 & : ( subseq-pos ( create$ pen_416qg_min-overruled $?gen208 $$$ $?gen209 ) ) ) ) ( test ( eq ( class ?gen205 ) min_imprisonment ) ) ( not ( and ?gen212 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive ?gen211 & : ( >= ?gen211 1 ) ) ) ?gen205 <- ( min_imprisonment ( positive-defeated $?gen207 & : ( not ( member$ pen_416qg_min $?gen207 ) ) ) ) ) ) => ( calc ( bind $?gen210 ( delete-member$ $?gen209 ( create$ pen_416qg_min-overruled $?gen208 ) ) ) ) ?gen205 <- ( min_imprisonment ( negative-overruled $?gen210 ) )"))

([pen_416qg_min-overruled] of derived-attribute-rule
   (pos-name pen_416qg_min-overruled-gen578)
   (depends-on declare art416_qualified_gain min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_416qg_min] ) ) ) ?gen212 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive ?gen211 & : ( >= ?gen211 1 ) ) ) ?gen205 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen208 ) ( negative-overruled $?gen209 & : ( not ( subseq-pos ( create$ pen_416qg_min-overruled $?gen208 $$$ $?gen209 ) ) ) ) ( positive-defeated $?gen207 & : ( not ( member$ pen_416qg_min $?gen207 ) ) ) ) ( test ( eq ( class ?gen205 ) min_imprisonment ) ) => ( calc ( bind $?gen210 ( create$ pen_416qg_min-overruled $?gen208 $?gen209 ) ) ) ?gen205 <- ( min_imprisonment ( negative-overruled $?gen210 ) )"))

([pen_416qg_min-support] of derived-attribute-rule
   (pos-name pen_416qg_min-support-gen580)
   (depends-on declare art416_qualified_gain min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_416qg_min] ) ) ) ?gen204 <- ( art416_qualified_gain ( defendant ?Defendant ) ) ?gen205 <- ( min_imprisonment ( value 1 ) ( positive-support $?gen207 & : ( not ( subseq-pos ( create$ pen_416qg_min ?gen204 $$$ $?gen207 ) ) ) ) ) ( test ( eq ( class ?gen205 ) min_imprisonment ) ) => ( calc ( bind $?gen210 ( create$ pen_416qg_min ?gen204 $?gen207 ) ) ) ?gen205 <- ( min_imprisonment ( positive-support $?gen210 ) )"))

([pen_416b_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_416b_max-defeasibly-dot-gen582)
   (depends-on declare max_imprisonment art416_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_416b_max] ) ) ) ?gen196 <- ( max_imprisonment ( value 5 ) ( positive 1 ) ( positive-derivator pen_416b_max $? ) ) ( test ( eq ( class ?gen196 ) max_imprisonment ) ) ( not ( and ?gen203 <- ( art416_basic ( defendant ?Defendant ) ( positive ?gen202 & : ( >= ?gen202 1 ) ) ) ?gen196 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen198 & : ( not ( member$ pen_416b_max $?gen198 ) ) ) ) ) ) => ?gen196 <- ( max_imprisonment ( positive 0 ) )"))

([pen_416b_max-defeasibly] of derived-attribute-rule
   (pos-name pen_416b_max-defeasibly-gen584)
   (depends-on declare art416_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_416b_max] ) ) ) ?gen203 <- ( art416_basic ( defendant ?Defendant ) ( positive ?gen202 & : ( >= ?gen202 1 ) ) ) ?gen196 <- ( max_imprisonment ( value 5 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen198 & : ( not ( member$ pen_416b_max $?gen198 ) ) ) ) ( test ( eq ( class ?gen196 ) max_imprisonment ) ) => ?gen196 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_416b_max ?gen203 ) )"))

([pen_416b_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_416b_max-overruled-dot-gen586)
   (depends-on declare max_imprisonment art416_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_416b_max] ) ) ) ?gen196 <- ( max_imprisonment ( value 5 ) ( negative-support $?gen199 ) ( negative-overruled $?gen200 & : ( subseq-pos ( create$ pen_416b_max-overruled $?gen199 $$$ $?gen200 ) ) ) ) ( test ( eq ( class ?gen196 ) max_imprisonment ) ) ( not ( and ?gen203 <- ( art416_basic ( defendant ?Defendant ) ( positive ?gen202 & : ( >= ?gen202 1 ) ) ) ?gen196 <- ( max_imprisonment ( positive-defeated $?gen198 & : ( not ( member$ pen_416b_max $?gen198 ) ) ) ) ) ) => ( calc ( bind $?gen201 ( delete-member$ $?gen200 ( create$ pen_416b_max-overruled $?gen199 ) ) ) ) ?gen196 <- ( max_imprisonment ( negative-overruled $?gen201 ) )"))

([pen_416b_max-overruled] of derived-attribute-rule
   (pos-name pen_416b_max-overruled-gen588)
   (depends-on declare art416_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_416b_max] ) ) ) ?gen203 <- ( art416_basic ( defendant ?Defendant ) ( positive ?gen202 & : ( >= ?gen202 1 ) ) ) ?gen196 <- ( max_imprisonment ( value 5 ) ( negative-support $?gen199 ) ( negative-overruled $?gen200 & : ( not ( subseq-pos ( create$ pen_416b_max-overruled $?gen199 $$$ $?gen200 ) ) ) ) ( positive-defeated $?gen198 & : ( not ( member$ pen_416b_max $?gen198 ) ) ) ) ( test ( eq ( class ?gen196 ) max_imprisonment ) ) => ( calc ( bind $?gen201 ( create$ pen_416b_max-overruled $?gen199 $?gen200 ) ) ) ?gen196 <- ( max_imprisonment ( negative-overruled $?gen201 ) )"))

([pen_416b_max-support] of derived-attribute-rule
   (pos-name pen_416b_max-support-gen590)
   (depends-on declare art416_basic max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_416b_max] ) ) ) ?gen195 <- ( art416_basic ( defendant ?Defendant ) ) ?gen196 <- ( max_imprisonment ( value 5 ) ( positive-support $?gen198 & : ( not ( subseq-pos ( create$ pen_416b_max ?gen195 $$$ $?gen198 ) ) ) ) ) ( test ( eq ( class ?gen196 ) max_imprisonment ) ) => ( calc ( bind $?gen201 ( create$ pen_416b_max ?gen195 $?gen198 ) ) ) ?gen196 <- ( max_imprisonment ( positive-support $?gen201 ) )"))

([pen_416b_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_416b_min-defeasibly-dot-gen592)
   (depends-on declare min_imprisonment art416_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_416b_min] ) ) ) ?gen187 <- ( min_imprisonment ( value 1 ) ( positive 1 ) ( positive-derivator pen_416b_min $? ) ) ( test ( eq ( class ?gen187 ) min_imprisonment ) ) ( not ( and ?gen194 <- ( art416_basic ( defendant ?Defendant ) ( positive ?gen193 & : ( >= ?gen193 1 ) ) ) ?gen187 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen189 & : ( not ( member$ pen_416b_min $?gen189 ) ) ) ) ) ) => ?gen187 <- ( min_imprisonment ( positive 0 ) )"))

([pen_416b_min-defeasibly] of derived-attribute-rule
   (pos-name pen_416b_min-defeasibly-gen594)
   (depends-on declare art416_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_416b_min] ) ) ) ?gen194 <- ( art416_basic ( defendant ?Defendant ) ( positive ?gen193 & : ( >= ?gen193 1 ) ) ) ?gen187 <- ( min_imprisonment ( value 1 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen189 & : ( not ( member$ pen_416b_min $?gen189 ) ) ) ) ( test ( eq ( class ?gen187 ) min_imprisonment ) ) => ?gen187 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_416b_min ?gen194 ) )"))

([pen_416b_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_416b_min-overruled-dot-gen596)
   (depends-on declare min_imprisonment art416_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_416b_min] ) ) ) ?gen187 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen190 ) ( negative-overruled $?gen191 & : ( subseq-pos ( create$ pen_416b_min-overruled $?gen190 $$$ $?gen191 ) ) ) ) ( test ( eq ( class ?gen187 ) min_imprisonment ) ) ( not ( and ?gen194 <- ( art416_basic ( defendant ?Defendant ) ( positive ?gen193 & : ( >= ?gen193 1 ) ) ) ?gen187 <- ( min_imprisonment ( positive-defeated $?gen189 & : ( not ( member$ pen_416b_min $?gen189 ) ) ) ) ) ) => ( calc ( bind $?gen192 ( delete-member$ $?gen191 ( create$ pen_416b_min-overruled $?gen190 ) ) ) ) ?gen187 <- ( min_imprisonment ( negative-overruled $?gen192 ) )"))

([pen_416b_min-overruled] of derived-attribute-rule
   (pos-name pen_416b_min-overruled-gen598)
   (depends-on declare art416_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_416b_min] ) ) ) ?gen194 <- ( art416_basic ( defendant ?Defendant ) ( positive ?gen193 & : ( >= ?gen193 1 ) ) ) ?gen187 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen190 ) ( negative-overruled $?gen191 & : ( not ( subseq-pos ( create$ pen_416b_min-overruled $?gen190 $$$ $?gen191 ) ) ) ) ( positive-defeated $?gen189 & : ( not ( member$ pen_416b_min $?gen189 ) ) ) ) ( test ( eq ( class ?gen187 ) min_imprisonment ) ) => ( calc ( bind $?gen192 ( create$ pen_416b_min-overruled $?gen190 $?gen191 ) ) ) ?gen187 <- ( min_imprisonment ( negative-overruled $?gen192 ) )"))

([pen_416b_min-support] of derived-attribute-rule
   (pos-name pen_416b_min-support-gen600)
   (depends-on declare art416_basic min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_416b_min] ) ) ) ?gen186 <- ( art416_basic ( defendant ?Defendant ) ) ?gen187 <- ( min_imprisonment ( value 1 ) ( positive-support $?gen189 & : ( not ( subseq-pos ( create$ pen_416b_min ?gen186 $$$ $?gen189 ) ) ) ) ) ( test ( eq ( class ?gen187 ) min_imprisonment ) ) => ( calc ( bind $?gen192 ( create$ pen_416b_min ?gen186 $?gen189 ) ) ) ?gen187 <- ( min_imprisonment ( positive-support $?gen192 ) )"))

([rule10-defeasibly-dot] of derived-attribute-rule
   (pos-name rule10-defeasibly-dot-gen602)
   (depends-on declare art424_basic lc:case lc:case art424_basic)
   (implies art424_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule10] ) ) ) ?gen176 <- ( art424_basic ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule10 $? ) ) ( test ( eq ( class ?gen176 ) art424_basic ) ) ( not ( and ?gen183 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ( positive ?gen182 & : ( >= ?gen182 1 ) ) ) ?gen185 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art424\" ) ( positive ?gen184 & : ( >= ?gen184 1 ) ) ) ?gen176 <- ( art424_basic ( negative ~ 2 ) ( positive-overruled $?gen178 & : ( not ( member$ rule10 $?gen178 ) ) ) ) ) ) => ?gen176 <- ( art424_basic ( positive 0 ) )"))

([rule10-defeasibly] of derived-attribute-rule
   (pos-name rule10-defeasibly-gen604)
   (depends-on declare lc:case lc:case art424_basic)
   (implies art424_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule10] ) ) ) ?gen183 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ( positive ?gen182 & : ( >= ?gen182 1 ) ) ) ?gen185 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art424\" ) ( positive ?gen184 & : ( >= ?gen184 1 ) ) ) ?gen176 <- ( art424_basic ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen178 & : ( not ( member$ rule10 $?gen178 ) ) ) ) ( test ( eq ( class ?gen176 ) art424_basic ) ) => ?gen176 <- ( art424_basic ( positive 1 ) ( positive-derivator rule10 ?gen183 ?gen185 ) )"))

([rule10-overruled-dot] of derived-attribute-rule
   (pos-name rule10-overruled-dot-gen606)
   (depends-on declare art424_basic lc:case lc:case art424_basic)
   (implies art424_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule10] ) ) ) ?gen176 <- ( art424_basic ( defendant ?Defendant ) ( negative-support $?gen179 ) ( negative-overruled $?gen180 & : ( subseq-pos ( create$ rule10-overruled $?gen179 $$$ $?gen180 ) ) ) ) ( test ( eq ( class ?gen176 ) art424_basic ) ) ( not ( and ?gen183 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ( positive ?gen182 & : ( >= ?gen182 1 ) ) ) ?gen185 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art424\" ) ( positive ?gen184 & : ( >= ?gen184 1 ) ) ) ?gen176 <- ( art424_basic ( positive-defeated $?gen178 & : ( not ( member$ rule10 $?gen178 ) ) ) ) ) ) => ( calc ( bind $?gen181 ( delete-member$ $?gen180 ( create$ rule10-overruled $?gen179 ) ) ) ) ?gen176 <- ( art424_basic ( negative-overruled $?gen181 ) )"))

([rule10-overruled] of derived-attribute-rule
   (pos-name rule10-overruled-gen608)
   (depends-on declare lc:case lc:case art424_basic)
   (implies art424_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule10] ) ) ) ?gen183 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ( positive ?gen182 & : ( >= ?gen182 1 ) ) ) ?gen185 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art424\" ) ( positive ?gen184 & : ( >= ?gen184 1 ) ) ) ?gen176 <- ( art424_basic ( defendant ?Defendant ) ( negative-support $?gen179 ) ( negative-overruled $?gen180 & : ( not ( subseq-pos ( create$ rule10-overruled $?gen179 $$$ $?gen180 ) ) ) ) ( positive-defeated $?gen178 & : ( not ( member$ rule10 $?gen178 ) ) ) ) ( test ( eq ( class ?gen176 ) art424_basic ) ) => ( calc ( bind $?gen181 ( create$ rule10-overruled $?gen179 $?gen180 ) ) ) ?gen176 <- ( art424_basic ( negative-overruled $?gen181 ) )"))

([rule10-support] of derived-attribute-rule
   (pos-name rule10-support-gen610)
   (depends-on declare lc:case lc:case art424_basic)
   (implies art424_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule10] ) ) ) ?gen174 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ) ?gen175 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art424\" ) ) ?gen176 <- ( art424_basic ( defendant ?Defendant ) ( positive-support $?gen178 & : ( not ( subseq-pos ( create$ rule10 ?gen174 ?gen175 $$$ $?gen178 ) ) ) ) ) ( test ( eq ( class ?gen176 ) art424_basic ) ) => ( calc ( bind $?gen181 ( create$ rule10 ?gen174 ?gen175 $?gen178 ) ) ) ?gen176 <- ( art424_basic ( positive-support $?gen181 ) )"))

([rule9_neg-defeasibly-dot] of derived-attribute-rule
   (pos-name rule9_neg-defeasibly-dot-gen612)
   (depends-on declare art423_basic art423_qualified art423_basic)
   (implies art423_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule9_neg] ) ) ) ?gen166 <- ( art423_basic ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule9_neg $? ) ) ( test ( eq ( class ?gen166 ) art423_basic ) ) ( not ( and ?gen173 <- ( art423_qualified ( defendant ?Defendant ) ( positive ?gen172 & : ( >= ?gen172 1 ) ) ) ?gen166 <- ( art423_basic ( positive ~ 2 ) ( negative-overruled $?gen168 & : ( not ( member$ rule9_neg $?gen168 ) ) ) ) ) ) => ?gen166 <- ( art423_basic ( negative 0 ) )"))

([rule9_neg-defeasibly] of derived-attribute-rule
   (pos-name rule9_neg-defeasibly-gen614)
   (depends-on declare art423_qualified art423_basic)
   (implies art423_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule9_neg] ) ) ) ?gen173 <- ( art423_qualified ( defendant ?Defendant ) ( positive ?gen172 & : ( >= ?gen172 1 ) ) ) ?gen166 <- ( art423_basic ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen168 & : ( not ( member$ rule9_neg $?gen168 ) ) ) ) ( test ( eq ( class ?gen166 ) art423_basic ) ) => ?gen166 <- ( art423_basic ( negative 1 ) ( negative-derivator rule9_neg ?gen173 ) )"))

([rule9_neg-overruled-dot] of derived-attribute-rule
   (pos-name rule9_neg-overruled-dot-gen616)
   (depends-on declare art423_basic art423_qualified art423_basic)
   (implies art423_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule9_neg] ) ) ) ?gen166 <- ( art423_basic ( defendant ?Defendant ) ( positive-support $?gen169 ) ( positive-overruled $?gen170 & : ( subseq-pos ( create$ rule9_neg-overruled $?gen169 $$$ $?gen170 ) ) ) ) ( test ( eq ( class ?gen166 ) art423_basic ) ) ( not ( and ?gen173 <- ( art423_qualified ( defendant ?Defendant ) ( positive ?gen172 & : ( >= ?gen172 1 ) ) ) ?gen166 <- ( art423_basic ( negative-defeated $?gen168 & : ( not ( member$ rule9_neg $?gen168 ) ) ) ) ) ) => ( calc ( bind $?gen171 ( delete-member$ $?gen170 ( create$ rule9_neg-overruled $?gen169 ) ) ) ) ?gen166 <- ( art423_basic ( positive-overruled $?gen171 ) )"))

([rule9_neg-overruled] of derived-attribute-rule
   (pos-name rule9_neg-overruled-gen618)
   (depends-on declare art423_qualified art423_basic)
   (implies art423_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule9_neg] ) ) ) ?gen173 <- ( art423_qualified ( defendant ?Defendant ) ( positive ?gen172 & : ( >= ?gen172 1 ) ) ) ?gen166 <- ( art423_basic ( defendant ?Defendant ) ( positive-support $?gen169 ) ( positive-overruled $?gen170 & : ( not ( subseq-pos ( create$ rule9_neg-overruled $?gen169 $$$ $?gen170 ) ) ) ) ( negative-defeated $?gen168 & : ( not ( member$ rule9_neg $?gen168 ) ) ) ) ( test ( eq ( class ?gen166 ) art423_basic ) ) => ( calc ( bind $?gen171 ( create$ rule9_neg-overruled $?gen169 $?gen170 ) ) ) ?gen166 <- ( art423_basic ( positive-overruled $?gen171 ) )"))

([rule9_neg-support] of derived-attribute-rule
   (pos-name rule9_neg-support-gen620)
   (depends-on declare art423_qualified art423_basic)
   (implies art423_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule9_neg] ) ) ) ?gen165 <- ( art423_qualified ( defendant ?Defendant ) ) ?gen166 <- ( art423_basic ( defendant ?Defendant ) ( negative-support $?gen168 & : ( not ( subseq-pos ( create$ rule9_neg ?gen165 $$$ $?gen168 ) ) ) ) ) ( test ( eq ( class ?gen166 ) art423_basic ) ) => ( calc ( bind $?gen171 ( create$ rule9_neg ?gen165 $?gen168 ) ) ) ?gen166 <- ( art423_basic ( negative-support $?gen171 ) )"))

([rule9-defeasibly-dot] of derived-attribute-rule
   (pos-name rule9-defeasibly-dot-gen622)
   (depends-on declare art423_qualified lc:case lc:case art423_qualified)
   (implies art423_qualified)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule9] ) ) ) ?gen155 <- ( art423_qualified ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule9 $? ) ) ( test ( eq ( class ?gen155 ) art423_qualified ) ) ( not ( and ?gen162 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ( positive ?gen161 & : ( >= ?gen161 1 ) ) ) ?gen164 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_bribery \"true\" ) ( positive ?gen163 & : ( >= ?gen163 1 ) ) ) ?gen155 <- ( art423_qualified ( negative ~ 2 ) ( positive-overruled $?gen157 & : ( not ( member$ rule9 $?gen157 ) ) ) ) ) ) => ?gen155 <- ( art423_qualified ( positive 0 ) )"))

([rule9-defeasibly] of derived-attribute-rule
   (pos-name rule9-defeasibly-gen624)
   (depends-on declare lc:case lc:case art423_qualified)
   (implies art423_qualified)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule9] ) ) ) ?gen162 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ( positive ?gen161 & : ( >= ?gen161 1 ) ) ) ?gen164 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_bribery \"true\" ) ( positive ?gen163 & : ( >= ?gen163 1 ) ) ) ?gen155 <- ( art423_qualified ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen157 & : ( not ( member$ rule9 $?gen157 ) ) ) ) ( test ( eq ( class ?gen155 ) art423_qualified ) ) => ?gen155 <- ( art423_qualified ( positive 1 ) ( positive-derivator rule9 ?gen162 ?gen164 ) )"))

([rule9-overruled-dot] of derived-attribute-rule
   (pos-name rule9-overruled-dot-gen626)
   (depends-on declare art423_qualified lc:case lc:case art423_qualified)
   (implies art423_qualified)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule9] ) ) ) ?gen155 <- ( art423_qualified ( defendant ?Defendant ) ( negative-support $?gen158 ) ( negative-overruled $?gen159 & : ( subseq-pos ( create$ rule9-overruled $?gen158 $$$ $?gen159 ) ) ) ) ( test ( eq ( class ?gen155 ) art423_qualified ) ) ( not ( and ?gen162 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ( positive ?gen161 & : ( >= ?gen161 1 ) ) ) ?gen164 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_bribery \"true\" ) ( positive ?gen163 & : ( >= ?gen163 1 ) ) ) ?gen155 <- ( art423_qualified ( positive-defeated $?gen157 & : ( not ( member$ rule9 $?gen157 ) ) ) ) ) ) => ( calc ( bind $?gen160 ( delete-member$ $?gen159 ( create$ rule9-overruled $?gen158 ) ) ) ) ?gen155 <- ( art423_qualified ( negative-overruled $?gen160 ) )"))

([rule9-overruled] of derived-attribute-rule
   (pos-name rule9-overruled-gen628)
   (depends-on declare lc:case lc:case art423_qualified)
   (implies art423_qualified)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule9] ) ) ) ?gen162 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ( positive ?gen161 & : ( >= ?gen161 1 ) ) ) ?gen164 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_bribery \"true\" ) ( positive ?gen163 & : ( >= ?gen163 1 ) ) ) ?gen155 <- ( art423_qualified ( defendant ?Defendant ) ( negative-support $?gen158 ) ( negative-overruled $?gen159 & : ( not ( subseq-pos ( create$ rule9-overruled $?gen158 $$$ $?gen159 ) ) ) ) ( positive-defeated $?gen157 & : ( not ( member$ rule9 $?gen157 ) ) ) ) ( test ( eq ( class ?gen155 ) art423_qualified ) ) => ( calc ( bind $?gen160 ( create$ rule9-overruled $?gen158 $?gen159 ) ) ) ?gen155 <- ( art423_qualified ( negative-overruled $?gen160 ) )"))

([rule9-support] of derived-attribute-rule
   (pos-name rule9-support-gen630)
   (depends-on declare lc:case lc:case art423_qualified)
   (implies art423_qualified)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule9] ) ) ) ?gen153 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ) ?gen154 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_bribery \"true\" ) ) ?gen155 <- ( art423_qualified ( defendant ?Defendant ) ( positive-support $?gen157 & : ( not ( subseq-pos ( create$ rule9 ?gen153 ?gen154 $$$ $?gen157 ) ) ) ) ) ( test ( eq ( class ?gen155 ) art423_qualified ) ) => ( calc ( bind $?gen160 ( create$ rule9 ?gen153 ?gen154 $?gen157 ) ) ) ?gen155 <- ( art423_qualified ( positive-support $?gen160 ) )"))

([rule8-defeasibly-dot] of derived-attribute-rule
   (pos-name rule8-defeasibly-dot-gen632)
   (depends-on declare art423_basic lc:case lc:case art423_basic)
   (implies art423_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule8] ) ) ) ?gen143 <- ( art423_basic ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule8 $? ) ) ( test ( eq ( class ?gen143 ) art423_basic ) ) ( not ( and ?gen150 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ( positive ?gen149 & : ( >= ?gen149 1 ) ) ) ?gen152 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ( positive ?gen151 & : ( >= ?gen151 1 ) ) ) ?gen143 <- ( art423_basic ( negative ~ 2 ) ( positive-overruled $?gen145 & : ( not ( member$ rule8 $?gen145 ) ) ) ) ) ) => ?gen143 <- ( art423_basic ( positive 0 ) )"))

([rule8-defeasibly] of derived-attribute-rule
   (pos-name rule8-defeasibly-gen634)
   (depends-on declare lc:case lc:case art423_basic)
   (implies art423_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule8] ) ) ) ?gen150 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ( positive ?gen149 & : ( >= ?gen149 1 ) ) ) ?gen152 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ( positive ?gen151 & : ( >= ?gen151 1 ) ) ) ?gen143 <- ( art423_basic ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen145 & : ( not ( member$ rule8 $?gen145 ) ) ) ) ( test ( eq ( class ?gen143 ) art423_basic ) ) => ?gen143 <- ( art423_basic ( positive 1 ) ( positive-derivator rule8 ?gen150 ?gen152 ) )"))

([rule8-overruled-dot] of derived-attribute-rule
   (pos-name rule8-overruled-dot-gen636)
   (depends-on declare art423_basic lc:case lc:case art423_basic)
   (implies art423_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule8] ) ) ) ?gen143 <- ( art423_basic ( defendant ?Defendant ) ( negative-support $?gen146 ) ( negative-overruled $?gen147 & : ( subseq-pos ( create$ rule8-overruled $?gen146 $$$ $?gen147 ) ) ) ) ( test ( eq ( class ?gen143 ) art423_basic ) ) ( not ( and ?gen150 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ( positive ?gen149 & : ( >= ?gen149 1 ) ) ) ?gen152 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ( positive ?gen151 & : ( >= ?gen151 1 ) ) ) ?gen143 <- ( art423_basic ( positive-defeated $?gen145 & : ( not ( member$ rule8 $?gen145 ) ) ) ) ) ) => ( calc ( bind $?gen148 ( delete-member$ $?gen147 ( create$ rule8-overruled $?gen146 ) ) ) ) ?gen143 <- ( art423_basic ( negative-overruled $?gen148 ) )"))

([rule8-overruled] of derived-attribute-rule
   (pos-name rule8-overruled-gen638)
   (depends-on declare lc:case lc:case art423_basic)
   (implies art423_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule8] ) ) ) ?gen150 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ( positive ?gen149 & : ( >= ?gen149 1 ) ) ) ?gen152 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ( positive ?gen151 & : ( >= ?gen151 1 ) ) ) ?gen143 <- ( art423_basic ( defendant ?Defendant ) ( negative-support $?gen146 ) ( negative-overruled $?gen147 & : ( not ( subseq-pos ( create$ rule8-overruled $?gen146 $$$ $?gen147 ) ) ) ) ( positive-defeated $?gen145 & : ( not ( member$ rule8 $?gen145 ) ) ) ) ( test ( eq ( class ?gen143 ) art423_basic ) ) => ( calc ( bind $?gen148 ( create$ rule8-overruled $?gen146 $?gen147 ) ) ) ?gen143 <- ( art423_basic ( negative-overruled $?gen148 ) )"))

([rule8-support] of derived-attribute-rule
   (pos-name rule8-support-gen640)
   (depends-on declare lc:case lc:case art423_basic)
   (implies art423_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule8] ) ) ) ?gen141 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ) ?gen142 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ) ?gen143 <- ( art423_basic ( defendant ?Defendant ) ( positive-support $?gen145 & : ( not ( subseq-pos ( create$ rule8 ?gen141 ?gen142 $$$ $?gen145 ) ) ) ) ) ( test ( eq ( class ?gen143 ) art423_basic ) ) => ( calc ( bind $?gen148 ( create$ rule8 ?gen141 ?gen142 $?gen145 ) ) ) ?gen143 <- ( art423_basic ( positive-support $?gen148 ) )"))

([rule7_neg-defeasibly-dot] of derived-attribute-rule
   (pos-name rule7_neg-defeasibly-dot-gen642)
   (depends-on declare art422_basic art422_organized art422_basic)
   (implies art422_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule7_neg] ) ) ) ?gen133 <- ( art422_basic ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule7_neg $? ) ) ( test ( eq ( class ?gen133 ) art422_basic ) ) ( not ( and ?gen140 <- ( art422_organized ( defendant ?Defendant ) ( positive ?gen139 & : ( >= ?gen139 1 ) ) ) ?gen133 <- ( art422_basic ( positive ~ 2 ) ( negative-overruled $?gen135 & : ( not ( member$ rule7_neg $?gen135 ) ) ) ) ) ) => ?gen133 <- ( art422_basic ( negative 0 ) )"))

([rule7_neg-defeasibly] of derived-attribute-rule
   (pos-name rule7_neg-defeasibly-gen644)
   (depends-on declare art422_organized art422_basic)
   (implies art422_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule7_neg] ) ) ) ?gen140 <- ( art422_organized ( defendant ?Defendant ) ( positive ?gen139 & : ( >= ?gen139 1 ) ) ) ?gen133 <- ( art422_basic ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen135 & : ( not ( member$ rule7_neg $?gen135 ) ) ) ) ( test ( eq ( class ?gen133 ) art422_basic ) ) => ?gen133 <- ( art422_basic ( negative 1 ) ( negative-derivator rule7_neg ?gen140 ) )"))

([rule7_neg-overruled-dot] of derived-attribute-rule
   (pos-name rule7_neg-overruled-dot-gen646)
   (depends-on declare art422_basic art422_organized art422_basic)
   (implies art422_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule7_neg] ) ) ) ?gen133 <- ( art422_basic ( defendant ?Defendant ) ( positive-support $?gen136 ) ( positive-overruled $?gen137 & : ( subseq-pos ( create$ rule7_neg-overruled $?gen136 $$$ $?gen137 ) ) ) ) ( test ( eq ( class ?gen133 ) art422_basic ) ) ( not ( and ?gen140 <- ( art422_organized ( defendant ?Defendant ) ( positive ?gen139 & : ( >= ?gen139 1 ) ) ) ?gen133 <- ( art422_basic ( negative-defeated $?gen135 & : ( not ( member$ rule7_neg $?gen135 ) ) ) ) ) ) => ( calc ( bind $?gen138 ( delete-member$ $?gen137 ( create$ rule7_neg-overruled $?gen136 ) ) ) ) ?gen133 <- ( art422_basic ( positive-overruled $?gen138 ) )"))

([rule7_neg-overruled] of derived-attribute-rule
   (pos-name rule7_neg-overruled-gen648)
   (depends-on declare art422_organized art422_basic)
   (implies art422_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule7_neg] ) ) ) ?gen140 <- ( art422_organized ( defendant ?Defendant ) ( positive ?gen139 & : ( >= ?gen139 1 ) ) ) ?gen133 <- ( art422_basic ( defendant ?Defendant ) ( positive-support $?gen136 ) ( positive-overruled $?gen137 & : ( not ( subseq-pos ( create$ rule7_neg-overruled $?gen136 $$$ $?gen137 ) ) ) ) ( negative-defeated $?gen135 & : ( not ( member$ rule7_neg $?gen135 ) ) ) ) ( test ( eq ( class ?gen133 ) art422_basic ) ) => ( calc ( bind $?gen138 ( create$ rule7_neg-overruled $?gen136 $?gen137 ) ) ) ?gen133 <- ( art422_basic ( positive-overruled $?gen138 ) )"))

([rule7_neg-support] of derived-attribute-rule
   (pos-name rule7_neg-support-gen650)
   (depends-on declare art422_organized art422_basic)
   (implies art422_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule7_neg] ) ) ) ?gen132 <- ( art422_organized ( defendant ?Defendant ) ) ?gen133 <- ( art422_basic ( defendant ?Defendant ) ( negative-support $?gen135 & : ( not ( subseq-pos ( create$ rule7_neg ?gen132 $$$ $?gen135 ) ) ) ) ) ( test ( eq ( class ?gen133 ) art422_basic ) ) => ( calc ( bind $?gen138 ( create$ rule7_neg ?gen132 $?gen135 ) ) ) ?gen133 <- ( art422_basic ( negative-support $?gen138 ) )"))

([rule7-defeasibly-dot] of derived-attribute-rule
   (pos-name rule7-defeasibly-dot-gen652)
   (depends-on declare art422_organized lc:case lc:case art422_organized)
   (implies art422_organized)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule7] ) ) ) ?gen122 <- ( art422_organized ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule7 $? ) ) ( test ( eq ( class ?gen122 ) art422_organized ) ) ( not ( and ?gen129 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ( positive ?gen128 & : ( >= ?gen128 1 ) ) ) ?gen131 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ( positive ?gen130 & : ( >= ?gen130 1 ) ) ) ?gen122 <- ( art422_organized ( negative ~ 2 ) ( positive-overruled $?gen124 & : ( not ( member$ rule7 $?gen124 ) ) ) ) ) ) => ?gen122 <- ( art422_organized ( positive 0 ) )"))

([rule7-defeasibly] of derived-attribute-rule
   (pos-name rule7-defeasibly-gen654)
   (depends-on declare lc:case lc:case art422_organized)
   (implies art422_organized)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule7] ) ) ) ?gen129 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ( positive ?gen128 & : ( >= ?gen128 1 ) ) ) ?gen131 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ( positive ?gen130 & : ( >= ?gen130 1 ) ) ) ?gen122 <- ( art422_organized ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen124 & : ( not ( member$ rule7 $?gen124 ) ) ) ) ( test ( eq ( class ?gen122 ) art422_organized ) ) => ?gen122 <- ( art422_organized ( positive 1 ) ( positive-derivator rule7 ?gen129 ?gen131 ) )"))

([rule7-overruled-dot] of derived-attribute-rule
   (pos-name rule7-overruled-dot-gen656)
   (depends-on declare art422_organized lc:case lc:case art422_organized)
   (implies art422_organized)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule7] ) ) ) ?gen122 <- ( art422_organized ( defendant ?Defendant ) ( negative-support $?gen125 ) ( negative-overruled $?gen126 & : ( subseq-pos ( create$ rule7-overruled $?gen125 $$$ $?gen126 ) ) ) ) ( test ( eq ( class ?gen122 ) art422_organized ) ) ( not ( and ?gen129 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ( positive ?gen128 & : ( >= ?gen128 1 ) ) ) ?gen131 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ( positive ?gen130 & : ( >= ?gen130 1 ) ) ) ?gen122 <- ( art422_organized ( positive-defeated $?gen124 & : ( not ( member$ rule7 $?gen124 ) ) ) ) ) ) => ( calc ( bind $?gen127 ( delete-member$ $?gen126 ( create$ rule7-overruled $?gen125 ) ) ) ) ?gen122 <- ( art422_organized ( negative-overruled $?gen127 ) )"))

([rule7-overruled] of derived-attribute-rule
   (pos-name rule7-overruled-gen658)
   (depends-on declare lc:case lc:case art422_organized)
   (implies art422_organized)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule7] ) ) ) ?gen129 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ( positive ?gen128 & : ( >= ?gen128 1 ) ) ) ?gen131 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ( positive ?gen130 & : ( >= ?gen130 1 ) ) ) ?gen122 <- ( art422_organized ( defendant ?Defendant ) ( negative-support $?gen125 ) ( negative-overruled $?gen126 & : ( not ( subseq-pos ( create$ rule7-overruled $?gen125 $$$ $?gen126 ) ) ) ) ( positive-defeated $?gen124 & : ( not ( member$ rule7 $?gen124 ) ) ) ) ( test ( eq ( class ?gen122 ) art422_organized ) ) => ( calc ( bind $?gen127 ( create$ rule7-overruled $?gen125 $?gen126 ) ) ) ?gen122 <- ( art422_organized ( negative-overruled $?gen127 ) )"))

([rule7-support] of derived-attribute-rule
   (pos-name rule7-support-gen660)
   (depends-on declare lc:case lc:case art422_organized)
   (implies art422_organized)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule7] ) ) ) ?gen120 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ) ?gen121 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ) ?gen122 <- ( art422_organized ( defendant ?Defendant ) ( positive-support $?gen124 & : ( not ( subseq-pos ( create$ rule7 ?gen120 ?gen121 $$$ $?gen124 ) ) ) ) ) ( test ( eq ( class ?gen122 ) art422_organized ) ) => ( calc ( bind $?gen127 ( create$ rule7 ?gen120 ?gen121 $?gen124 ) ) ) ?gen122 <- ( art422_organized ( positive-support $?gen127 ) )"))

([rule6-defeasibly-dot] of derived-attribute-rule
   (pos-name rule6-defeasibly-dot-gen662)
   (depends-on declare art422_basic lc:case art422_basic)
   (implies art422_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule6] ) ) ) ?gen112 <- ( art422_basic ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule6 $? ) ) ( test ( eq ( class ?gen112 ) art422_basic ) ) ( not ( and ?gen119 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ( positive ?gen118 & : ( >= ?gen118 1 ) ) ) ?gen112 <- ( art422_basic ( negative ~ 2 ) ( positive-overruled $?gen114 & : ( not ( member$ rule6 $?gen114 ) ) ) ) ) ) => ?gen112 <- ( art422_basic ( positive 0 ) )"))

([rule6-defeasibly] of derived-attribute-rule
   (pos-name rule6-defeasibly-gen664)
   (depends-on declare lc:case art422_basic)
   (implies art422_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule6] ) ) ) ?gen119 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ( positive ?gen118 & : ( >= ?gen118 1 ) ) ) ?gen112 <- ( art422_basic ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen114 & : ( not ( member$ rule6 $?gen114 ) ) ) ) ( test ( eq ( class ?gen112 ) art422_basic ) ) => ?gen112 <- ( art422_basic ( positive 1 ) ( positive-derivator rule6 ?gen119 ) )"))

([rule6-overruled-dot] of derived-attribute-rule
   (pos-name rule6-overruled-dot-gen666)
   (depends-on declare art422_basic lc:case art422_basic)
   (implies art422_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule6] ) ) ) ?gen112 <- ( art422_basic ( defendant ?Defendant ) ( negative-support $?gen115 ) ( negative-overruled $?gen116 & : ( subseq-pos ( create$ rule6-overruled $?gen115 $$$ $?gen116 ) ) ) ) ( test ( eq ( class ?gen112 ) art422_basic ) ) ( not ( and ?gen119 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ( positive ?gen118 & : ( >= ?gen118 1 ) ) ) ?gen112 <- ( art422_basic ( positive-defeated $?gen114 & : ( not ( member$ rule6 $?gen114 ) ) ) ) ) ) => ( calc ( bind $?gen117 ( delete-member$ $?gen116 ( create$ rule6-overruled $?gen115 ) ) ) ) ?gen112 <- ( art422_basic ( negative-overruled $?gen117 ) )"))

([rule6-overruled] of derived-attribute-rule
   (pos-name rule6-overruled-gen668)
   (depends-on declare lc:case art422_basic)
   (implies art422_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule6] ) ) ) ?gen119 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ( positive ?gen118 & : ( >= ?gen118 1 ) ) ) ?gen112 <- ( art422_basic ( defendant ?Defendant ) ( negative-support $?gen115 ) ( negative-overruled $?gen116 & : ( not ( subseq-pos ( create$ rule6-overruled $?gen115 $$$ $?gen116 ) ) ) ) ( positive-defeated $?gen114 & : ( not ( member$ rule6 $?gen114 ) ) ) ) ( test ( eq ( class ?gen112 ) art422_basic ) ) => ( calc ( bind $?gen117 ( create$ rule6-overruled $?gen115 $?gen116 ) ) ) ?gen112 <- ( art422_basic ( negative-overruled $?gen117 ) )"))

([rule6-support] of derived-attribute-rule
   (pos-name rule6-support-gen670)
   (depends-on declare lc:case art422_basic)
   (implies art422_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule6] ) ) ) ?gen111 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ) ?gen112 <- ( art422_basic ( defendant ?Defendant ) ( positive-support $?gen114 & : ( not ( subseq-pos ( create$ rule6 ?gen111 $$$ $?gen114 ) ) ) ) ) ( test ( eq ( class ?gen112 ) art422_basic ) ) => ( calc ( bind $?gen117 ( create$ rule6 ?gen111 $?gen114 ) ) ) ?gen112 <- ( art422_basic ( positive-support $?gen117 ) )"))

([rule5_neg-defeasibly-dot] of derived-attribute-rule
   (pos-name rule5_neg-defeasibly-dot-gen672)
   (depends-on declare art420_basic art420_qualified art420_basic)
   (implies art420_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule5_neg] ) ) ) ?gen103 <- ( art420_basic ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule5_neg $? ) ) ( test ( eq ( class ?gen103 ) art420_basic ) ) ( not ( and ?gen110 <- ( art420_qualified ( defendant ?Defendant ) ( positive ?gen109 & : ( >= ?gen109 1 ) ) ) ?gen103 <- ( art420_basic ( positive ~ 2 ) ( negative-overruled $?gen105 & : ( not ( member$ rule5_neg $?gen105 ) ) ) ) ) ) => ?gen103 <- ( art420_basic ( negative 0 ) )"))

([rule5_neg-defeasibly] of derived-attribute-rule
   (pos-name rule5_neg-defeasibly-gen674)
   (depends-on declare art420_qualified art420_basic)
   (implies art420_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule5_neg] ) ) ) ?gen110 <- ( art420_qualified ( defendant ?Defendant ) ( positive ?gen109 & : ( >= ?gen109 1 ) ) ) ?gen103 <- ( art420_basic ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen105 & : ( not ( member$ rule5_neg $?gen105 ) ) ) ) ( test ( eq ( class ?gen103 ) art420_basic ) ) => ?gen103 <- ( art420_basic ( negative 1 ) ( negative-derivator rule5_neg ?gen110 ) )"))

([rule5_neg-overruled-dot] of derived-attribute-rule
   (pos-name rule5_neg-overruled-dot-gen676)
   (depends-on declare art420_basic art420_qualified art420_basic)
   (implies art420_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule5_neg] ) ) ) ?gen103 <- ( art420_basic ( defendant ?Defendant ) ( positive-support $?gen106 ) ( positive-overruled $?gen107 & : ( subseq-pos ( create$ rule5_neg-overruled $?gen106 $$$ $?gen107 ) ) ) ) ( test ( eq ( class ?gen103 ) art420_basic ) ) ( not ( and ?gen110 <- ( art420_qualified ( defendant ?Defendant ) ( positive ?gen109 & : ( >= ?gen109 1 ) ) ) ?gen103 <- ( art420_basic ( negative-defeated $?gen105 & : ( not ( member$ rule5_neg $?gen105 ) ) ) ) ) ) => ( calc ( bind $?gen108 ( delete-member$ $?gen107 ( create$ rule5_neg-overruled $?gen106 ) ) ) ) ?gen103 <- ( art420_basic ( positive-overruled $?gen108 ) )"))

([rule5_neg-overruled] of derived-attribute-rule
   (pos-name rule5_neg-overruled-gen678)
   (depends-on declare art420_qualified art420_basic)
   (implies art420_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule5_neg] ) ) ) ?gen110 <- ( art420_qualified ( defendant ?Defendant ) ( positive ?gen109 & : ( >= ?gen109 1 ) ) ) ?gen103 <- ( art420_basic ( defendant ?Defendant ) ( positive-support $?gen106 ) ( positive-overruled $?gen107 & : ( not ( subseq-pos ( create$ rule5_neg-overruled $?gen106 $$$ $?gen107 ) ) ) ) ( negative-defeated $?gen105 & : ( not ( member$ rule5_neg $?gen105 ) ) ) ) ( test ( eq ( class ?gen103 ) art420_basic ) ) => ( calc ( bind $?gen108 ( create$ rule5_neg-overruled $?gen106 $?gen107 ) ) ) ?gen103 <- ( art420_basic ( positive-overruled $?gen108 ) )"))

([rule5_neg-support] of derived-attribute-rule
   (pos-name rule5_neg-support-gen680)
   (depends-on declare art420_qualified art420_basic)
   (implies art420_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule5_neg] ) ) ) ?gen102 <- ( art420_qualified ( defendant ?Defendant ) ) ?gen103 <- ( art420_basic ( defendant ?Defendant ) ( negative-support $?gen105 & : ( not ( subseq-pos ( create$ rule5_neg ?gen102 $$$ $?gen105 ) ) ) ) ) ( test ( eq ( class ?gen103 ) art420_basic ) ) => ( calc ( bind $?gen108 ( create$ rule5_neg ?gen102 $?gen105 ) ) ) ?gen103 <- ( art420_basic ( negative-support $?gen108 ) )"))

([rule5-defeasibly-dot] of derived-attribute-rule
   (pos-name rule5-defeasibly-dot-gen682)
   (depends-on declare art420_qualified lc:case lc:case art420_qualified)
   (implies art420_qualified)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule5] ) ) ) ?gen92 <- ( art420_qualified ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule5 $? ) ) ( test ( eq ( class ?gen92 ) art420_qualified ) ) ( not ( and ?gen99 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ( positive ?gen98 & : ( >= ?gen98 1 ) ) ) ?gen101 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ( positive ?gen100 & : ( >= ?gen100 1 ) ) ) ?gen92 <- ( art420_qualified ( negative ~ 2 ) ( positive-overruled $?gen94 & : ( not ( member$ rule5 $?gen94 ) ) ) ) ) ) => ?gen92 <- ( art420_qualified ( positive 0 ) )"))

([rule5-defeasibly] of derived-attribute-rule
   (pos-name rule5-defeasibly-gen684)
   (depends-on declare lc:case lc:case art420_qualified)
   (implies art420_qualified)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule5] ) ) ) ?gen99 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ( positive ?gen98 & : ( >= ?gen98 1 ) ) ) ?gen101 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ( positive ?gen100 & : ( >= ?gen100 1 ) ) ) ?gen92 <- ( art420_qualified ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen94 & : ( not ( member$ rule5 $?gen94 ) ) ) ) ( test ( eq ( class ?gen92 ) art420_qualified ) ) => ?gen92 <- ( art420_qualified ( positive 1 ) ( positive-derivator rule5 ?gen99 ?gen101 ) )"))

([rule5-overruled-dot] of derived-attribute-rule
   (pos-name rule5-overruled-dot-gen686)
   (depends-on declare art420_qualified lc:case lc:case art420_qualified)
   (implies art420_qualified)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule5] ) ) ) ?gen92 <- ( art420_qualified ( defendant ?Defendant ) ( negative-support $?gen95 ) ( negative-overruled $?gen96 & : ( subseq-pos ( create$ rule5-overruled $?gen95 $$$ $?gen96 ) ) ) ) ( test ( eq ( class ?gen92 ) art420_qualified ) ) ( not ( and ?gen99 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ( positive ?gen98 & : ( >= ?gen98 1 ) ) ) ?gen101 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ( positive ?gen100 & : ( >= ?gen100 1 ) ) ) ?gen92 <- ( art420_qualified ( positive-defeated $?gen94 & : ( not ( member$ rule5 $?gen94 ) ) ) ) ) ) => ( calc ( bind $?gen97 ( delete-member$ $?gen96 ( create$ rule5-overruled $?gen95 ) ) ) ) ?gen92 <- ( art420_qualified ( negative-overruled $?gen97 ) )"))

([rule5-overruled] of derived-attribute-rule
   (pos-name rule5-overruled-gen688)
   (depends-on declare lc:case lc:case art420_qualified)
   (implies art420_qualified)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule5] ) ) ) ?gen99 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ( positive ?gen98 & : ( >= ?gen98 1 ) ) ) ?gen101 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ( positive ?gen100 & : ( >= ?gen100 1 ) ) ) ?gen92 <- ( art420_qualified ( defendant ?Defendant ) ( negative-support $?gen95 ) ( negative-overruled $?gen96 & : ( not ( subseq-pos ( create$ rule5-overruled $?gen95 $$$ $?gen96 ) ) ) ) ( positive-defeated $?gen94 & : ( not ( member$ rule5 $?gen94 ) ) ) ) ( test ( eq ( class ?gen92 ) art420_qualified ) ) => ( calc ( bind $?gen97 ( create$ rule5-overruled $?gen95 $?gen96 ) ) ) ?gen92 <- ( art420_qualified ( negative-overruled $?gen97 ) )"))

([rule5-support] of derived-attribute-rule
   (pos-name rule5-support-gen690)
   (depends-on declare lc:case lc:case art420_qualified)
   (implies art420_qualified)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule5] ) ) ) ?gen90 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ) ?gen91 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ) ?gen92 <- ( art420_qualified ( defendant ?Defendant ) ( positive-support $?gen94 & : ( not ( subseq-pos ( create$ rule5 ?gen90 ?gen91 $$$ $?gen94 ) ) ) ) ) ( test ( eq ( class ?gen92 ) art420_qualified ) ) => ( calc ( bind $?gen97 ( create$ rule5 ?gen90 ?gen91 $?gen94 ) ) ) ?gen92 <- ( art420_qualified ( positive-support $?gen97 ) )"))

([rule4-defeasibly-dot] of derived-attribute-rule
   (pos-name rule4-defeasibly-dot-gen692)
   (depends-on declare art420_basic lc:case lc:case art420_basic)
   (implies art420_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule4] ) ) ) ?gen80 <- ( art420_basic ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule4 $? ) ) ( test ( eq ( class ?gen80 ) art420_basic ) ) ( not ( and ?gen87 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ( positive ?gen86 & : ( >= ?gen86 1 ) ) ) ?gen89 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ( positive ?gen88 & : ( >= ?gen88 1 ) ) ) ?gen80 <- ( art420_basic ( negative ~ 2 ) ( positive-overruled $?gen82 & : ( not ( member$ rule4 $?gen82 ) ) ) ) ) ) => ?gen80 <- ( art420_basic ( positive 0 ) )"))

([rule4-defeasibly] of derived-attribute-rule
   (pos-name rule4-defeasibly-gen694)
   (depends-on declare lc:case lc:case art420_basic)
   (implies art420_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule4] ) ) ) ?gen87 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ( positive ?gen86 & : ( >= ?gen86 1 ) ) ) ?gen89 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ( positive ?gen88 & : ( >= ?gen88 1 ) ) ) ?gen80 <- ( art420_basic ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen82 & : ( not ( member$ rule4 $?gen82 ) ) ) ) ( test ( eq ( class ?gen80 ) art420_basic ) ) => ?gen80 <- ( art420_basic ( positive 1 ) ( positive-derivator rule4 ?gen87 ?gen89 ) )"))

([rule4-overruled-dot] of derived-attribute-rule
   (pos-name rule4-overruled-dot-gen696)
   (depends-on declare art420_basic lc:case lc:case art420_basic)
   (implies art420_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule4] ) ) ) ?gen80 <- ( art420_basic ( defendant ?Defendant ) ( negative-support $?gen83 ) ( negative-overruled $?gen84 & : ( subseq-pos ( create$ rule4-overruled $?gen83 $$$ $?gen84 ) ) ) ) ( test ( eq ( class ?gen80 ) art420_basic ) ) ( not ( and ?gen87 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ( positive ?gen86 & : ( >= ?gen86 1 ) ) ) ?gen89 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ( positive ?gen88 & : ( >= ?gen88 1 ) ) ) ?gen80 <- ( art420_basic ( positive-defeated $?gen82 & : ( not ( member$ rule4 $?gen82 ) ) ) ) ) ) => ( calc ( bind $?gen85 ( delete-member$ $?gen84 ( create$ rule4-overruled $?gen83 ) ) ) ) ?gen80 <- ( art420_basic ( negative-overruled $?gen85 ) )"))

([rule4-overruled] of derived-attribute-rule
   (pos-name rule4-overruled-gen698)
   (depends-on declare lc:case lc:case art420_basic)
   (implies art420_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule4] ) ) ) ?gen87 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ( positive ?gen86 & : ( >= ?gen86 1 ) ) ) ?gen89 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ( positive ?gen88 & : ( >= ?gen88 1 ) ) ) ?gen80 <- ( art420_basic ( defendant ?Defendant ) ( negative-support $?gen83 ) ( negative-overruled $?gen84 & : ( not ( subseq-pos ( create$ rule4-overruled $?gen83 $$$ $?gen84 ) ) ) ) ( positive-defeated $?gen82 & : ( not ( member$ rule4 $?gen82 ) ) ) ) ( test ( eq ( class ?gen80 ) art420_basic ) ) => ( calc ( bind $?gen85 ( create$ rule4-overruled $?gen83 $?gen84 ) ) ) ?gen80 <- ( art420_basic ( negative-overruled $?gen85 ) )"))

([rule4-support] of derived-attribute-rule
   (pos-name rule4-support-gen700)
   (depends-on declare lc:case lc:case art420_basic)
   (implies art420_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule4] ) ) ) ?gen78 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ) ?gen79 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ) ?gen80 <- ( art420_basic ( defendant ?Defendant ) ( positive-support $?gen82 & : ( not ( subseq-pos ( create$ rule4 ?gen78 ?gen79 $$$ $?gen82 ) ) ) ) ) ( test ( eq ( class ?gen80 ) art420_basic ) ) => ( calc ( bind $?gen85 ( create$ rule4 ?gen78 ?gen79 $?gen82 ) ) ) ?gen80 <- ( art420_basic ( positive-support $?gen85 ) )"))

([rule3_neg2-defeasibly-dot] of derived-attribute-rule
   (pos-name rule3_neg2-defeasibly-dot-gen702)
   (depends-on declare art416_qualified_gain art416_organized art416_qualified_gain)
   (implies art416_qualified_gain)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule3_neg2] ) ) ) ?gen70 <- ( art416_qualified_gain ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule3_neg2 $? ) ) ( test ( eq ( class ?gen70 ) art416_qualified_gain ) ) ( not ( and ?gen77 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen76 & : ( >= ?gen76 1 ) ) ) ?gen70 <- ( art416_qualified_gain ( positive ~ 2 ) ( negative-overruled $?gen72 & : ( not ( member$ rule3_neg2 $?gen72 ) ) ) ) ) ) => ?gen70 <- ( art416_qualified_gain ( negative 0 ) )"))

([rule3_neg2-defeasibly] of derived-attribute-rule
   (pos-name rule3_neg2-defeasibly-gen704)
   (depends-on declare art416_organized art416_qualified_gain)
   (implies art416_qualified_gain)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule3_neg2] ) ) ) ?gen77 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen76 & : ( >= ?gen76 1 ) ) ) ?gen70 <- ( art416_qualified_gain ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen72 & : ( not ( member$ rule3_neg2 $?gen72 ) ) ) ) ( test ( eq ( class ?gen70 ) art416_qualified_gain ) ) => ?gen70 <- ( art416_qualified_gain ( negative 1 ) ( negative-derivator rule3_neg2 ?gen77 ) )"))

([rule3_neg2-overruled-dot] of derived-attribute-rule
   (pos-name rule3_neg2-overruled-dot-gen706)
   (depends-on declare art416_qualified_gain art416_organized art416_qualified_gain)
   (implies art416_qualified_gain)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule3_neg2] ) ) ) ?gen70 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive-support $?gen73 ) ( positive-overruled $?gen74 & : ( subseq-pos ( create$ rule3_neg2-overruled $?gen73 $$$ $?gen74 ) ) ) ) ( test ( eq ( class ?gen70 ) art416_qualified_gain ) ) ( not ( and ?gen77 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen76 & : ( >= ?gen76 1 ) ) ) ?gen70 <- ( art416_qualified_gain ( negative-defeated $?gen72 & : ( not ( member$ rule3_neg2 $?gen72 ) ) ) ) ) ) => ( calc ( bind $?gen75 ( delete-member$ $?gen74 ( create$ rule3_neg2-overruled $?gen73 ) ) ) ) ?gen70 <- ( art416_qualified_gain ( positive-overruled $?gen75 ) )"))

([rule3_neg2-overruled] of derived-attribute-rule
   (pos-name rule3_neg2-overruled-gen708)
   (depends-on declare art416_organized art416_qualified_gain)
   (implies art416_qualified_gain)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule3_neg2] ) ) ) ?gen77 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen76 & : ( >= ?gen76 1 ) ) ) ?gen70 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive-support $?gen73 ) ( positive-overruled $?gen74 & : ( not ( subseq-pos ( create$ rule3_neg2-overruled $?gen73 $$$ $?gen74 ) ) ) ) ( negative-defeated $?gen72 & : ( not ( member$ rule3_neg2 $?gen72 ) ) ) ) ( test ( eq ( class ?gen70 ) art416_qualified_gain ) ) => ( calc ( bind $?gen75 ( create$ rule3_neg2-overruled $?gen73 $?gen74 ) ) ) ?gen70 <- ( art416_qualified_gain ( positive-overruled $?gen75 ) )"))

([rule3_neg2-support] of derived-attribute-rule
   (pos-name rule3_neg2-support-gen710)
   (depends-on declare art416_organized art416_qualified_gain)
   (implies art416_qualified_gain)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule3_neg2] ) ) ) ?gen69 <- ( art416_organized ( defendant ?Defendant ) ) ?gen70 <- ( art416_qualified_gain ( defendant ?Defendant ) ( negative-support $?gen72 & : ( not ( subseq-pos ( create$ rule3_neg2 ?gen69 $$$ $?gen72 ) ) ) ) ) ( test ( eq ( class ?gen70 ) art416_qualified_gain ) ) => ( calc ( bind $?gen75 ( create$ rule3_neg2 ?gen69 $?gen72 ) ) ) ?gen70 <- ( art416_qualified_gain ( negative-support $?gen75 ) )"))

([rule3_neg1-defeasibly-dot] of derived-attribute-rule
   (pos-name rule3_neg1-defeasibly-dot-gen712)
   (depends-on declare art416_basic art416_organized art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule3_neg1] ) ) ) ?gen61 <- ( art416_basic ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule3_neg1 $? ) ) ( test ( eq ( class ?gen61 ) art416_basic ) ) ( not ( and ?gen68 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen67 & : ( >= ?gen67 1 ) ) ) ?gen61 <- ( art416_basic ( positive ~ 2 ) ( negative-overruled $?gen63 & : ( not ( member$ rule3_neg1 $?gen63 ) ) ) ) ) ) => ?gen61 <- ( art416_basic ( negative 0 ) )"))

([rule3_neg1-defeasibly] of derived-attribute-rule
   (pos-name rule3_neg1-defeasibly-gen714)
   (depends-on declare art416_organized art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule3_neg1] ) ) ) ?gen68 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen67 & : ( >= ?gen67 1 ) ) ) ?gen61 <- ( art416_basic ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen63 & : ( not ( member$ rule3_neg1 $?gen63 ) ) ) ) ( test ( eq ( class ?gen61 ) art416_basic ) ) => ?gen61 <- ( art416_basic ( negative 1 ) ( negative-derivator rule3_neg1 ?gen68 ) )"))

([rule3_neg1-overruled-dot] of derived-attribute-rule
   (pos-name rule3_neg1-overruled-dot-gen716)
   (depends-on declare art416_basic art416_organized art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule3_neg1] ) ) ) ?gen61 <- ( art416_basic ( defendant ?Defendant ) ( positive-support $?gen64 ) ( positive-overruled $?gen65 & : ( subseq-pos ( create$ rule3_neg1-overruled $?gen64 $$$ $?gen65 ) ) ) ) ( test ( eq ( class ?gen61 ) art416_basic ) ) ( not ( and ?gen68 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen67 & : ( >= ?gen67 1 ) ) ) ?gen61 <- ( art416_basic ( negative-defeated $?gen63 & : ( not ( member$ rule3_neg1 $?gen63 ) ) ) ) ) ) => ( calc ( bind $?gen66 ( delete-member$ $?gen65 ( create$ rule3_neg1-overruled $?gen64 ) ) ) ) ?gen61 <- ( art416_basic ( positive-overruled $?gen66 ) )"))

([rule3_neg1-overruled] of derived-attribute-rule
   (pos-name rule3_neg1-overruled-gen718)
   (depends-on declare art416_organized art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule3_neg1] ) ) ) ?gen68 <- ( art416_organized ( defendant ?Defendant ) ( positive ?gen67 & : ( >= ?gen67 1 ) ) ) ?gen61 <- ( art416_basic ( defendant ?Defendant ) ( positive-support $?gen64 ) ( positive-overruled $?gen65 & : ( not ( subseq-pos ( create$ rule3_neg1-overruled $?gen64 $$$ $?gen65 ) ) ) ) ( negative-defeated $?gen63 & : ( not ( member$ rule3_neg1 $?gen63 ) ) ) ) ( test ( eq ( class ?gen61 ) art416_basic ) ) => ( calc ( bind $?gen66 ( create$ rule3_neg1-overruled $?gen64 $?gen65 ) ) ) ?gen61 <- ( art416_basic ( positive-overruled $?gen66 ) )"))

([rule3_neg1-support] of derived-attribute-rule
   (pos-name rule3_neg1-support-gen720)
   (depends-on declare art416_organized art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule3_neg1] ) ) ) ?gen60 <- ( art416_organized ( defendant ?Defendant ) ) ?gen61 <- ( art416_basic ( defendant ?Defendant ) ( negative-support $?gen63 & : ( not ( subseq-pos ( create$ rule3_neg1 ?gen60 $$$ $?gen63 ) ) ) ) ) ( test ( eq ( class ?gen61 ) art416_basic ) ) => ( calc ( bind $?gen66 ( create$ rule3_neg1 ?gen60 $?gen63 ) ) ) ?gen61 <- ( art416_basic ( negative-support $?gen66 ) )"))

([rule3-defeasibly-dot] of derived-attribute-rule
   (pos-name rule3-defeasibly-dot-gen722)
   (depends-on declare art416_organized lc:case lc:case art416_organized)
   (implies art416_organized)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule3] ) ) ) ?gen50 <- ( art416_organized ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule3 $? ) ) ( test ( eq ( class ?gen50 ) art416_organized ) ) ( not ( and ?gen57 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ( positive ?gen56 & : ( >= ?gen56 1 ) ) ) ?gen59 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ( positive ?gen58 & : ( >= ?gen58 1 ) ) ) ?gen50 <- ( art416_organized ( negative ~ 2 ) ( positive-overruled $?gen52 & : ( not ( member$ rule3 $?gen52 ) ) ) ) ) ) => ?gen50 <- ( art416_organized ( positive 0 ) )"))

([rule3-defeasibly] of derived-attribute-rule
   (pos-name rule3-defeasibly-gen724)
   (depends-on declare lc:case lc:case art416_organized)
   (implies art416_organized)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule3] ) ) ) ?gen57 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ( positive ?gen56 & : ( >= ?gen56 1 ) ) ) ?gen59 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ( positive ?gen58 & : ( >= ?gen58 1 ) ) ) ?gen50 <- ( art416_organized ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen52 & : ( not ( member$ rule3 $?gen52 ) ) ) ) ( test ( eq ( class ?gen50 ) art416_organized ) ) => ?gen50 <- ( art416_organized ( positive 1 ) ( positive-derivator rule3 ?gen57 ?gen59 ) )"))

([rule3-overruled-dot] of derived-attribute-rule
   (pos-name rule3-overruled-dot-gen726)
   (depends-on declare art416_organized lc:case lc:case art416_organized)
   (implies art416_organized)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule3] ) ) ) ?gen50 <- ( art416_organized ( defendant ?Defendant ) ( negative-support $?gen53 ) ( negative-overruled $?gen54 & : ( subseq-pos ( create$ rule3-overruled $?gen53 $$$ $?gen54 ) ) ) ) ( test ( eq ( class ?gen50 ) art416_organized ) ) ( not ( and ?gen57 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ( positive ?gen56 & : ( >= ?gen56 1 ) ) ) ?gen59 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ( positive ?gen58 & : ( >= ?gen58 1 ) ) ) ?gen50 <- ( art416_organized ( positive-defeated $?gen52 & : ( not ( member$ rule3 $?gen52 ) ) ) ) ) ) => ( calc ( bind $?gen55 ( delete-member$ $?gen54 ( create$ rule3-overruled $?gen53 ) ) ) ) ?gen50 <- ( art416_organized ( negative-overruled $?gen55 ) )"))

([rule3-overruled] of derived-attribute-rule
   (pos-name rule3-overruled-gen728)
   (depends-on declare lc:case lc:case art416_organized)
   (implies art416_organized)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule3] ) ) ) ?gen57 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ( positive ?gen56 & : ( >= ?gen56 1 ) ) ) ?gen59 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ( positive ?gen58 & : ( >= ?gen58 1 ) ) ) ?gen50 <- ( art416_organized ( defendant ?Defendant ) ( negative-support $?gen53 ) ( negative-overruled $?gen54 & : ( not ( subseq-pos ( create$ rule3-overruled $?gen53 $$$ $?gen54 ) ) ) ) ( positive-defeated $?gen52 & : ( not ( member$ rule3 $?gen52 ) ) ) ) ( test ( eq ( class ?gen50 ) art416_organized ) ) => ( calc ( bind $?gen55 ( create$ rule3-overruled $?gen53 $?gen54 ) ) ) ?gen50 <- ( art416_organized ( negative-overruled $?gen55 ) )"))

([rule3-support] of derived-attribute-rule
   (pos-name rule3-support-gen730)
   (depends-on declare lc:case lc:case art416_organized)
   (implies art416_organized)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule3] ) ) ) ?gen48 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ) ?gen49 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ) ?gen50 <- ( art416_organized ( defendant ?Defendant ) ( positive-support $?gen52 & : ( not ( subseq-pos ( create$ rule3 ?gen48 ?gen49 $$$ $?gen52 ) ) ) ) ) ( test ( eq ( class ?gen50 ) art416_organized ) ) => ( calc ( bind $?gen55 ( create$ rule3 ?gen48 ?gen49 $?gen52 ) ) ) ?gen50 <- ( art416_organized ( positive-support $?gen55 ) )"))

([rule2_neg-defeasibly-dot] of derived-attribute-rule
   (pos-name rule2_neg-defeasibly-dot-gen732)
   (depends-on declare art416_basic art416_qualified_gain art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule2_neg] ) ) ) ?gen40 <- ( art416_basic ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule2_neg $? ) ) ( test ( eq ( class ?gen40 ) art416_basic ) ) ( not ( and ?gen47 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive ?gen46 & : ( >= ?gen46 1 ) ) ) ?gen40 <- ( art416_basic ( positive ~ 2 ) ( negative-overruled $?gen42 & : ( not ( member$ rule2_neg $?gen42 ) ) ) ) ) ) => ?gen40 <- ( art416_basic ( negative 0 ) )"))

([rule2_neg-defeasibly] of derived-attribute-rule
   (pos-name rule2_neg-defeasibly-gen734)
   (depends-on declare art416_qualified_gain art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule2_neg] ) ) ) ?gen47 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive ?gen46 & : ( >= ?gen46 1 ) ) ) ?gen40 <- ( art416_basic ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen42 & : ( not ( member$ rule2_neg $?gen42 ) ) ) ) ( test ( eq ( class ?gen40 ) art416_basic ) ) => ?gen40 <- ( art416_basic ( negative 1 ) ( negative-derivator rule2_neg ?gen47 ) )"))

([rule2_neg-overruled-dot] of derived-attribute-rule
   (pos-name rule2_neg-overruled-dot-gen736)
   (depends-on declare art416_basic art416_qualified_gain art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule2_neg] ) ) ) ?gen40 <- ( art416_basic ( defendant ?Defendant ) ( positive-support $?gen43 ) ( positive-overruled $?gen44 & : ( subseq-pos ( create$ rule2_neg-overruled $?gen43 $$$ $?gen44 ) ) ) ) ( test ( eq ( class ?gen40 ) art416_basic ) ) ( not ( and ?gen47 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive ?gen46 & : ( >= ?gen46 1 ) ) ) ?gen40 <- ( art416_basic ( negative-defeated $?gen42 & : ( not ( member$ rule2_neg $?gen42 ) ) ) ) ) ) => ( calc ( bind $?gen45 ( delete-member$ $?gen44 ( create$ rule2_neg-overruled $?gen43 ) ) ) ) ?gen40 <- ( art416_basic ( positive-overruled $?gen45 ) )"))

([rule2_neg-overruled] of derived-attribute-rule
   (pos-name rule2_neg-overruled-gen738)
   (depends-on declare art416_qualified_gain art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule2_neg] ) ) ) ?gen47 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive ?gen46 & : ( >= ?gen46 1 ) ) ) ?gen40 <- ( art416_basic ( defendant ?Defendant ) ( positive-support $?gen43 ) ( positive-overruled $?gen44 & : ( not ( subseq-pos ( create$ rule2_neg-overruled $?gen43 $$$ $?gen44 ) ) ) ) ( negative-defeated $?gen42 & : ( not ( member$ rule2_neg $?gen42 ) ) ) ) ( test ( eq ( class ?gen40 ) art416_basic ) ) => ( calc ( bind $?gen45 ( create$ rule2_neg-overruled $?gen43 $?gen44 ) ) ) ?gen40 <- ( art416_basic ( positive-overruled $?gen45 ) )"))

([rule2_neg-support] of derived-attribute-rule
   (pos-name rule2_neg-support-gen740)
   (depends-on declare art416_qualified_gain art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule2_neg] ) ) ) ?gen39 <- ( art416_qualified_gain ( defendant ?Defendant ) ) ?gen40 <- ( art416_basic ( defendant ?Defendant ) ( negative-support $?gen42 & : ( not ( subseq-pos ( create$ rule2_neg ?gen39 $$$ $?gen42 ) ) ) ) ) ( test ( eq ( class ?gen40 ) art416_basic ) ) => ( calc ( bind $?gen45 ( create$ rule2_neg ?gen39 $?gen42 ) ) ) ?gen40 <- ( art416_basic ( negative-support $?gen45 ) )"))

([rule2-defeasibly-dot] of derived-attribute-rule
   (pos-name rule2-defeasibly-dot-gen742)
   (depends-on declare art416_qualified_gain lc:case lc:case art416_qualified_gain)
   (implies art416_qualified_gain)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule2] ) ) ) ?gen29 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule2 $? ) ) ( test ( eq ( class ?gen29 ) art416_qualified_gain ) ) ( not ( and ?gen36 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ( positive ?gen35 & : ( >= ?gen35 1 ) ) ) ?gen38 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ( positive ?gen37 & : ( >= ?gen37 1 ) ) ) ?gen29 <- ( art416_qualified_gain ( negative ~ 2 ) ( positive-overruled $?gen31 & : ( not ( member$ rule2 $?gen31 ) ) ) ) ) ) => ?gen29 <- ( art416_qualified_gain ( positive 0 ) )"))

([rule2-defeasibly] of derived-attribute-rule
   (pos-name rule2-defeasibly-gen744)
   (depends-on declare lc:case lc:case art416_qualified_gain)
   (implies art416_qualified_gain)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule2] ) ) ) ?gen36 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ( positive ?gen35 & : ( >= ?gen35 1 ) ) ) ?gen38 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ( positive ?gen37 & : ( >= ?gen37 1 ) ) ) ?gen29 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen31 & : ( not ( member$ rule2 $?gen31 ) ) ) ) ( test ( eq ( class ?gen29 ) art416_qualified_gain ) ) => ?gen29 <- ( art416_qualified_gain ( positive 1 ) ( positive-derivator rule2 ?gen36 ?gen38 ) )"))

([rule2-overruled-dot] of derived-attribute-rule
   (pos-name rule2-overruled-dot-gen746)
   (depends-on declare art416_qualified_gain lc:case lc:case art416_qualified_gain)
   (implies art416_qualified_gain)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule2] ) ) ) ?gen29 <- ( art416_qualified_gain ( defendant ?Defendant ) ( negative-support $?gen32 ) ( negative-overruled $?gen33 & : ( subseq-pos ( create$ rule2-overruled $?gen32 $$$ $?gen33 ) ) ) ) ( test ( eq ( class ?gen29 ) art416_qualified_gain ) ) ( not ( and ?gen36 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ( positive ?gen35 & : ( >= ?gen35 1 ) ) ) ?gen38 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ( positive ?gen37 & : ( >= ?gen37 1 ) ) ) ?gen29 <- ( art416_qualified_gain ( positive-defeated $?gen31 & : ( not ( member$ rule2 $?gen31 ) ) ) ) ) ) => ( calc ( bind $?gen34 ( delete-member$ $?gen33 ( create$ rule2-overruled $?gen32 ) ) ) ) ?gen29 <- ( art416_qualified_gain ( negative-overruled $?gen34 ) )"))

([rule2-overruled] of derived-attribute-rule
   (pos-name rule2-overruled-gen748)
   (depends-on declare lc:case lc:case art416_qualified_gain)
   (implies art416_qualified_gain)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule2] ) ) ) ?gen36 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ( positive ?gen35 & : ( >= ?gen35 1 ) ) ) ?gen38 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ( positive ?gen37 & : ( >= ?gen37 1 ) ) ) ?gen29 <- ( art416_qualified_gain ( defendant ?Defendant ) ( negative-support $?gen32 ) ( negative-overruled $?gen33 & : ( not ( subseq-pos ( create$ rule2-overruled $?gen32 $$$ $?gen33 ) ) ) ) ( positive-defeated $?gen31 & : ( not ( member$ rule2 $?gen31 ) ) ) ) ( test ( eq ( class ?gen29 ) art416_qualified_gain ) ) => ( calc ( bind $?gen34 ( create$ rule2-overruled $?gen32 $?gen33 ) ) ) ?gen29 <- ( art416_qualified_gain ( negative-overruled $?gen34 ) )"))

([rule2-support] of derived-attribute-rule
   (pos-name rule2-support-gen750)
   (depends-on declare lc:case lc:case art416_qualified_gain)
   (implies art416_qualified_gain)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule2] ) ) ) ?gen27 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ) ?gen28 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ) ?gen29 <- ( art416_qualified_gain ( defendant ?Defendant ) ( positive-support $?gen31 & : ( not ( subseq-pos ( create$ rule2 ?gen27 ?gen28 $$$ $?gen31 ) ) ) ) ) ( test ( eq ( class ?gen29 ) art416_qualified_gain ) ) => ( calc ( bind $?gen34 ( create$ rule2 ?gen27 ?gen28 $?gen31 ) ) ) ?gen29 <- ( art416_qualified_gain ( positive-support $?gen34 ) )"))

([rule1-defeasibly-dot] of derived-attribute-rule
   (pos-name rule1-defeasibly-dot-gen752)
   (depends-on declare art416_basic lc:case lc:case art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule1] ) ) ) ?gen17 <- ( art416_basic ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule1 $? ) ) ( test ( eq ( class ?gen17 ) art416_basic ) ) ( not ( and ?gen24 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ( positive ?gen23 & : ( >= ?gen23 1 ) ) ) ?gen26 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ( positive ?gen25 & : ( >= ?gen25 1 ) ) ) ?gen17 <- ( art416_basic ( negative ~ 2 ) ( positive-overruled $?gen19 & : ( not ( member$ rule1 $?gen19 ) ) ) ) ) ) => ?gen17 <- ( art416_basic ( positive 0 ) )"))

([rule1-defeasibly] of derived-attribute-rule
   (pos-name rule1-defeasibly-gen754)
   (depends-on declare lc:case lc:case art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule1] ) ) ) ?gen24 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ( positive ?gen23 & : ( >= ?gen23 1 ) ) ) ?gen26 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ( positive ?gen25 & : ( >= ?gen25 1 ) ) ) ?gen17 <- ( art416_basic ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen19 & : ( not ( member$ rule1 $?gen19 ) ) ) ) ( test ( eq ( class ?gen17 ) art416_basic ) ) => ?gen17 <- ( art416_basic ( positive 1 ) ( positive-derivator rule1 ?gen24 ?gen26 ) )"))

([rule1-overruled-dot] of derived-attribute-rule
   (pos-name rule1-overruled-dot-gen756)
   (depends-on declare art416_basic lc:case lc:case art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule1] ) ) ) ?gen17 <- ( art416_basic ( defendant ?Defendant ) ( negative-support $?gen20 ) ( negative-overruled $?gen21 & : ( subseq-pos ( create$ rule1-overruled $?gen20 $$$ $?gen21 ) ) ) ) ( test ( eq ( class ?gen17 ) art416_basic ) ) ( not ( and ?gen24 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ( positive ?gen23 & : ( >= ?gen23 1 ) ) ) ?gen26 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ( positive ?gen25 & : ( >= ?gen25 1 ) ) ) ?gen17 <- ( art416_basic ( positive-defeated $?gen19 & : ( not ( member$ rule1 $?gen19 ) ) ) ) ) ) => ( calc ( bind $?gen22 ( delete-member$ $?gen21 ( create$ rule1-overruled $?gen20 ) ) ) ) ?gen17 <- ( art416_basic ( negative-overruled $?gen22 ) )"))

([rule1-overruled] of derived-attribute-rule
   (pos-name rule1-overruled-gen758)
   (depends-on declare lc:case lc:case art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule1] ) ) ) ?gen24 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ( positive ?gen23 & : ( >= ?gen23 1 ) ) ) ?gen26 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ( positive ?gen25 & : ( >= ?gen25 1 ) ) ) ?gen17 <- ( art416_basic ( defendant ?Defendant ) ( negative-support $?gen20 ) ( negative-overruled $?gen21 & : ( not ( subseq-pos ( create$ rule1-overruled $?gen20 $$$ $?gen21 ) ) ) ) ( positive-defeated $?gen19 & : ( not ( member$ rule1 $?gen19 ) ) ) ) ( test ( eq ( class ?gen17 ) art416_basic ) ) => ( calc ( bind $?gen22 ( create$ rule1-overruled $?gen20 $?gen21 ) ) ) ?gen17 <- ( art416_basic ( negative-overruled $?gen22 ) )"))

([rule1-support] of derived-attribute-rule
   (pos-name rule1-support-gen760)
   (depends-on declare lc:case lc:case art416_basic)
   (implies art416_basic)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule1] ) ) ) ?gen15 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ) ?gen16 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ) ?gen17 <- ( art416_basic ( defendant ?Defendant ) ( positive-support $?gen19 & : ( not ( subseq-pos ( create$ rule1 ?gen15 ?gen16 $$$ $?gen19 ) ) ) ) ) ( test ( eq ( class ?gen17 ) art416_basic ) ) => ( calc ( bind $?gen22 ( create$ rule1 ?gen15 ?gen16 $?gen19 ) ) ) ?gen17 <- ( art416_basic ( positive-support $?gen22 ) )"))

([pen_424b_max-deductive] of ntm-deductive-rule
   (pos-name pen_424b_max-deductive-gen401)
   (depends-on art424_basic max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen357 <- ( art424_basic ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 5 ) ) ) => ( max_imprisonment ( value 5 ) )")
   (production-rule "( defrule pen_424b_max-deductive-gen401 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen357 ) ( is-a art424_basic ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 5 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 5 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 5 ) ) ) ( make-instance ?oid of max_imprisonment ( value 5 ) ) )")
   (derived-class max_imprisonment))

([pen_424b_min-deductive] of ntm-deductive-rule
   (pos-name pen_424b_min-deductive-gen400)
   (depends-on art424_basic min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen348 <- ( art424_basic ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 1 ) ) ) => ( min_imprisonment ( value 1 ) )")
   (production-rule "( defrule pen_424b_min-deductive-gen400 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen348 ) ( is-a art424_basic ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 1 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ( make-instance ?oid of min_imprisonment ( value 1 ) ) )")
   (derived-class min_imprisonment))

([pen_423q_max-deductive] of ntm-deductive-rule
   (pos-name pen_423q_max-deductive-gen399)
   (depends-on art423_qualified max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen339 <- ( art423_qualified ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 12 ) ) ) => ( max_imprisonment ( value 12 ) )")
   (production-rule "( defrule pen_423q_max-deductive-gen399 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen339 ) ( is-a art423_qualified ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 12 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 12 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 12 ) ) ) ( make-instance ?oid of max_imprisonment ( value 12 ) ) )")
   (derived-class max_imprisonment))

([pen_423q_min-deductive] of ntm-deductive-rule
   (pos-name pen_423q_min-deductive-gen398)
   (depends-on art423_qualified min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen330 <- ( art423_qualified ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 2 ) ) ) => ( min_imprisonment ( value 2 ) )")
   (production-rule "( defrule pen_423q_min-deductive-gen398 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen330 ) ( is-a art423_qualified ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 2 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 2 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 2 ) ) ) ( make-instance ?oid of min_imprisonment ( value 2 ) ) )")
   (derived-class min_imprisonment))

([pen_423b_max-deductive] of ntm-deductive-rule
   (pos-name pen_423b_max-deductive-gen397)
   (depends-on art423_basic max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen321 <- ( art423_basic ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 8 ) ) ) => ( max_imprisonment ( value 8 ) )")
   (production-rule "( defrule pen_423b_max-deductive-gen397 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen321 ) ( is-a art423_basic ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 8 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 8 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 8 ) ) ) ( make-instance ?oid of max_imprisonment ( value 8 ) ) )")
   (derived-class max_imprisonment))

([pen_423b_min-deductive] of ntm-deductive-rule
   (pos-name pen_423b_min-deductive-gen396)
   (depends-on art423_basic min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen312 <- ( art423_basic ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 1 ) ) ) => ( min_imprisonment ( value 1 ) )")
   (production-rule "( defrule pen_423b_min-deductive-gen396 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen312 ) ( is-a art423_basic ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 1 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ( make-instance ?oid of min_imprisonment ( value 1 ) ) )")
   (derived-class min_imprisonment))

([pen_422org_max-deductive] of ntm-deductive-rule
   (pos-name pen_422org_max-deductive-gen395)
   (depends-on art422_organized max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen303 <- ( art422_organized ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 8 ) ) ) => ( max_imprisonment ( value 8 ) )")
   (production-rule "( defrule pen_422org_max-deductive-gen395 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen303 ) ( is-a art422_organized ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 8 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 8 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 8 ) ) ) ( make-instance ?oid of max_imprisonment ( value 8 ) ) )")
   (derived-class max_imprisonment))

([pen_422org_min-deductive] of ntm-deductive-rule
   (pos-name pen_422org_min-deductive-gen394)
   (depends-on art422_organized min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen294 <- ( art422_organized ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 1 ) ) ) => ( min_imprisonment ( value 1 ) )")
   (production-rule "( defrule pen_422org_min-deductive-gen394 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen294 ) ( is-a art422_organized ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 1 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ( make-instance ?oid of min_imprisonment ( value 1 ) ) )")
   (derived-class min_imprisonment))

([pen_422b_max-deductive] of ntm-deductive-rule
   (pos-name pen_422b_max-deductive-gen393)
   (depends-on art422_basic max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen285 <- ( art422_basic ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 5 ) ) ) => ( max_imprisonment ( value 5 ) )")
   (production-rule "( defrule pen_422b_max-deductive-gen393 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen285 ) ( is-a art422_basic ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 5 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 5 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 5 ) ) ) ( make-instance ?oid of max_imprisonment ( value 5 ) ) )")
   (derived-class max_imprisonment))

([pen_422b_min-deductive] of ntm-deductive-rule
   (pos-name pen_422b_min-deductive-gen392)
   (depends-on art422_basic min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen276 <- ( art422_basic ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 1 ) ) ) => ( min_imprisonment ( value 1 ) )")
   (production-rule "( defrule pen_422b_min-deductive-gen392 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen276 ) ( is-a art422_basic ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 1 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ( make-instance ?oid of min_imprisonment ( value 1 ) ) )")
   (derived-class min_imprisonment))

([pen_420q_max-deductive] of ntm-deductive-rule
   (pos-name pen_420q_max-deductive-gen391)
   (depends-on art420_qualified max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen267 <- ( art420_qualified ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 10 ) ) ) => ( max_imprisonment ( value 10 ) )")
   (production-rule "( defrule pen_420q_max-deductive-gen391 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen267 ) ( is-a art420_qualified ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 10 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 10 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 10 ) ) ) ( make-instance ?oid of max_imprisonment ( value 10 ) ) )")
   (derived-class max_imprisonment))

([pen_420q_min-deductive] of ntm-deductive-rule
   (pos-name pen_420q_min-deductive-gen390)
   (depends-on art420_qualified min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen258 <- ( art420_qualified ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 2 ) ) ) => ( min_imprisonment ( value 2 ) )")
   (production-rule "( defrule pen_420q_min-deductive-gen390 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen258 ) ( is-a art420_qualified ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 2 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 2 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 2 ) ) ) ( make-instance ?oid of min_imprisonment ( value 2 ) ) )")
   (derived-class min_imprisonment))

([pen_420b_max-deductive] of ntm-deductive-rule
   (pos-name pen_420b_max-deductive-gen389)
   (depends-on art420_basic max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen249 <- ( art420_basic ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 8 ) ) ) => ( max_imprisonment ( value 8 ) )")
   (production-rule "( defrule pen_420b_max-deductive-gen389 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen249 ) ( is-a art420_basic ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 8 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 8 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 8 ) ) ) ( make-instance ?oid of max_imprisonment ( value 8 ) ) )")
   (derived-class max_imprisonment))

([pen_420b_min-deductive] of ntm-deductive-rule
   (pos-name pen_420b_min-deductive-gen388)
   (depends-on art420_basic min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen240 <- ( art420_basic ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 1 ) ) ) => ( min_imprisonment ( value 1 ) )")
   (production-rule "( defrule pen_420b_min-deductive-gen388 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen240 ) ( is-a art420_basic ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 1 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ( make-instance ?oid of min_imprisonment ( value 1 ) ) )")
   (derived-class min_imprisonment))

([pen_416org_max-deductive] of ntm-deductive-rule
   (pos-name pen_416org_max-deductive-gen387)
   (depends-on art416_organized max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen231 <- ( art416_organized ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 12 ) ) ) => ( max_imprisonment ( value 12 ) )")
   (production-rule "( defrule pen_416org_max-deductive-gen387 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen231 ) ( is-a art416_organized ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 12 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 12 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 12 ) ) ) ( make-instance ?oid of max_imprisonment ( value 12 ) ) )")
   (derived-class max_imprisonment))

([pen_416org_min-deductive] of ntm-deductive-rule
   (pos-name pen_416org_min-deductive-gen386)
   (depends-on art416_organized min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen222 <- ( art416_organized ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 2 ) ) ) => ( min_imprisonment ( value 2 ) )")
   (production-rule "( defrule pen_416org_min-deductive-gen386 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen222 ) ( is-a art416_organized ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 2 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 2 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 2 ) ) ) ( make-instance ?oid of min_imprisonment ( value 2 ) ) )")
   (derived-class min_imprisonment))

([pen_416qg_max-deductive] of ntm-deductive-rule
   (pos-name pen_416qg_max-deductive-gen385)
   (depends-on art416_qualified_gain max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen213 <- ( art416_qualified_gain ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 10 ) ) ) => ( max_imprisonment ( value 10 ) )")
   (production-rule "( defrule pen_416qg_max-deductive-gen385 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen213 ) ( is-a art416_qualified_gain ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 10 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 10 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 10 ) ) ) ( make-instance ?oid of max_imprisonment ( value 10 ) ) )")
   (derived-class max_imprisonment))

([pen_416qg_min-deductive] of ntm-deductive-rule
   (pos-name pen_416qg_min-deductive-gen384)
   (depends-on art416_qualified_gain min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen204 <- ( art416_qualified_gain ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 1 ) ) ) => ( min_imprisonment ( value 1 ) )")
   (production-rule "( defrule pen_416qg_min-deductive-gen384 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen204 ) ( is-a art416_qualified_gain ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 1 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ( make-instance ?oid of min_imprisonment ( value 1 ) ) )")
   (derived-class min_imprisonment))

([pen_416b_max-deductive] of ntm-deductive-rule
   (pos-name pen_416b_max-deductive-gen383)
   (depends-on art416_basic max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen195 <- ( art416_basic ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 5 ) ) ) => ( max_imprisonment ( value 5 ) )")
   (production-rule "( defrule pen_416b_max-deductive-gen383 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen195 ) ( is-a art416_basic ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 5 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 5 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 5 ) ) ) ( make-instance ?oid of max_imprisonment ( value 5 ) ) )")
   (derived-class max_imprisonment))

([pen_416b_min-deductive] of ntm-deductive-rule
   (pos-name pen_416b_min-deductive-gen382)
   (depends-on art416_basic min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen186 <- ( art416_basic ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 1 ) ) ) => ( min_imprisonment ( value 1 ) )")
   (production-rule "( defrule pen_416b_min-deductive-gen382 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen186 ) ( is-a art416_basic ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 1 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ( make-instance ?oid of min_imprisonment ( value 1 ) ) )")
   (derived-class min_imprisonment))

([rule10-deductive] of ntm-deductive-rule
   (pos-name rule10-deductive-gen381)
   (depends-on lc:case lc:case art424_basic)
   (implies art424_basic)
   (deductive-rule "?gen174 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ) ?gen175 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art424\" ) ) ( not ( art424_basic ( defendant ?Defendant ) ) ) => ( art424_basic ( defendant ?Defendant ) )")
   (production-rule "( defrule rule10-deductive-gen381 ( declare ( salience ( calc-salience art424_basic ) ) ) ( run-deductive-rules ) ( object ( name ?gen174 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ) ( object ( name ?gen175 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:crime_type \"art424\" ) ) ( not ( object ( is-a art424_basic ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art424_basic ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art424_basic ?Defendant ) ) ) ( make-instance ?oid of art424_basic ( defendant ?Defendant ) ) )")
   (derived-class art424_basic))

([rule9_neg-deductive] of ntm-deductive-rule
   (pos-name rule9_neg-deductive-gen380)
   (depends-on art423_qualified art423_basic)
   (implies art423_basic)
   (deductive-rule "?gen165 <- ( art423_qualified ( defendant ?Defendant ) ) ( not ( art423_basic ( defendant ?Defendant ) ) ) => ( art423_basic ( defendant ?Defendant ) )")
   (production-rule "( defrule rule9_neg-deductive-gen380 ( declare ( salience ( calc-salience art423_basic ) ) ) ( run-deductive-rules ) ( object ( name ?gen165 ) ( is-a art423_qualified ) ( defendant ?Defendant ) ) ( not ( object ( is-a art423_basic ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art423_basic ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art423_basic ?Defendant ) ) ) ( make-instance ?oid of art423_basic ( defendant ?Defendant ) ) )")
   (derived-class art423_basic))

([rule9-deductive] of ntm-deductive-rule
   (pos-name rule9-deductive-gen379)
   (depends-on lc:case lc:case art423_qualified)
   (implies art423_qualified)
   (deductive-rule "?gen153 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ) ?gen154 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_bribery \"true\" ) ) ( not ( art423_qualified ( defendant ?Defendant ) ) ) => ( art423_qualified ( defendant ?Defendant ) )")
   (production-rule "( defrule rule9-deductive-gen379 ( declare ( salience ( calc-salience art423_qualified ) ) ) ( run-deductive-rules ) ( object ( name ?gen153 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ) ( object ( name ?gen154 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:high_bribery \"true\" ) ) ( not ( object ( is-a art423_qualified ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art423_qualified ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art423_qualified ?Defendant ) ) ) ( make-instance ?oid of art423_qualified ( defendant ?Defendant ) ) )")
   (derived-class art423_qualified))

([rule8-deductive] of ntm-deductive-rule
   (pos-name rule8-deductive-gen378)
   (depends-on lc:case lc:case art423_basic)
   (implies art423_basic)
   (deductive-rule "?gen141 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ) ?gen142 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ) ( not ( art423_basic ( defendant ?Defendant ) ) ) => ( art423_basic ( defendant ?Defendant ) )")
   (production-rule "( defrule rule8-deductive-gen378 ( declare ( salience ( calc-salience art423_basic ) ) ) ( run-deductive-rules ) ( object ( name ?gen141 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:bribery_involved \"true\" ) ) ( object ( name ?gen142 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:crime_type \"art423\" ) ) ( not ( object ( is-a art423_basic ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art423_basic ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art423_basic ?Defendant ) ) ) ( make-instance ?oid of art423_basic ( defendant ?Defendant ) ) )")
   (derived-class art423_basic))

([rule7_neg-deductive] of ntm-deductive-rule
   (pos-name rule7_neg-deductive-gen377)
   (depends-on art422_organized art422_basic)
   (implies art422_basic)
   (deductive-rule "?gen132 <- ( art422_organized ( defendant ?Defendant ) ) ( not ( art422_basic ( defendant ?Defendant ) ) ) => ( art422_basic ( defendant ?Defendant ) )")
   (production-rule "( defrule rule7_neg-deductive-gen377 ( declare ( salience ( calc-salience art422_basic ) ) ) ( run-deductive-rules ) ( object ( name ?gen132 ) ( is-a art422_organized ) ( defendant ?Defendant ) ) ( not ( object ( is-a art422_basic ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art422_basic ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art422_basic ?Defendant ) ) ) ( make-instance ?oid of art422_basic ( defendant ?Defendant ) ) )")
   (derived-class art422_basic))

([rule7-deductive] of ntm-deductive-rule
   (pos-name rule7-deductive-gen376)
   (depends-on lc:case lc:case art422_organized)
   (implies art422_organized)
   (deductive-rule "?gen120 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ) ?gen121 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ) ( not ( art422_organized ( defendant ?Defendant ) ) ) => ( art422_organized ( defendant ?Defendant ) )")
   (production-rule "( defrule rule7-deductive-gen376 ( declare ( salience ( calc-salience art422_organized ) ) ) ( run-deductive-rules ) ( object ( name ?gen120 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ) ( object ( name ?gen121 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ) ( not ( object ( is-a art422_organized ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art422_organized ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art422_organized ?Defendant ) ) ) ( make-instance ?oid of art422_organized ( defendant ?Defendant ) ) )")
   (derived-class art422_organized))

([rule6-deductive] of ntm-deductive-rule
   (pos-name rule6-deductive-gen375)
   (depends-on lc:case art422_basic)
   (implies art422_basic)
   (deductive-rule "?gen111 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ) ( not ( art422_basic ( defendant ?Defendant ) ) ) => ( art422_basic ( defendant ?Defendant ) )")
   (production-rule "( defrule rule6-deductive-gen375 ( declare ( salience ( calc-salience art422_basic ) ) ) ( run-deductive-rules ) ( object ( name ?gen111 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:crime_type \"art422\" ) ) ( not ( object ( is-a art422_basic ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art422_basic ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art422_basic ?Defendant ) ) ) ( make-instance ?oid of art422_basic ( defendant ?Defendant ) ) )")
   (derived-class art422_basic))

([rule5_neg-deductive] of ntm-deductive-rule
   (pos-name rule5_neg-deductive-gen374)
   (depends-on art420_qualified art420_basic)
   (implies art420_basic)
   (deductive-rule "?gen102 <- ( art420_qualified ( defendant ?Defendant ) ) ( not ( art420_basic ( defendant ?Defendant ) ) ) => ( art420_basic ( defendant ?Defendant ) )")
   (production-rule "( defrule rule5_neg-deductive-gen374 ( declare ( salience ( calc-salience art420_basic ) ) ) ( run-deductive-rules ) ( object ( name ?gen102 ) ( is-a art420_qualified ) ( defendant ?Defendant ) ) ( not ( object ( is-a art420_basic ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art420_basic ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art420_basic ?Defendant ) ) ) ( make-instance ?oid of art420_basic ( defendant ?Defendant ) ) )")
   (derived-class art420_basic))

([rule5-deductive] of ntm-deductive-rule
   (pos-name rule5-deductive-gen373)
   (depends-on lc:case lc:case art420_qualified)
   (implies art420_qualified)
   (deductive-rule "?gen90 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ) ?gen91 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ) ( not ( art420_qualified ( defendant ?Defendant ) ) ) => ( art420_qualified ( defendant ?Defendant ) )")
   (production-rule "( defrule rule5-deductive-gen373 ( declare ( salience ( calc-salience art420_qualified ) ) ) ( run-deductive-rules ) ( object ( name ?gen90 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ) ( object ( name ?gen91 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ) ( not ( object ( is-a art420_qualified ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art420_qualified ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art420_qualified ?Defendant ) ) ) ( make-instance ?oid of art420_qualified ( defendant ?Defendant ) ) )")
   (derived-class art420_qualified))

([rule4-deductive] of ntm-deductive-rule
   (pos-name rule4-deductive-gen372)
   (depends-on lc:case lc:case art420_basic)
   (implies art420_basic)
   (deductive-rule "?gen78 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ) ?gen79 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ) ( not ( art420_basic ( defendant ?Defendant ) ) ) => ( art420_basic ( defendant ?Defendant ) )")
   (production-rule "( defrule rule4-deductive-gen372 ( declare ( salience ( calc-salience art420_basic ) ) ) ( run-deductive-rules ) ( object ( name ?gen78 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ) ( object ( name ?gen79 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:crime_type \"art420\" ) ) ( not ( object ( is-a art420_basic ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art420_basic ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art420_basic ?Defendant ) ) ) ( make-instance ?oid of art420_basic ( defendant ?Defendant ) ) )")
   (derived-class art420_basic))

([rule3_neg2-deductive] of ntm-deductive-rule
   (pos-name rule3_neg2-deductive-gen371)
   (depends-on art416_organized art416_qualified_gain)
   (implies art416_qualified_gain)
   (deductive-rule "?gen69 <- ( art416_organized ( defendant ?Defendant ) ) ( not ( art416_qualified_gain ( defendant ?Defendant ) ) ) => ( art416_qualified_gain ( defendant ?Defendant ) )")
   (production-rule "( defrule rule3_neg2-deductive-gen371 ( declare ( salience ( calc-salience art416_qualified_gain ) ) ) ( run-deductive-rules ) ( object ( name ?gen69 ) ( is-a art416_organized ) ( defendant ?Defendant ) ) ( not ( object ( is-a art416_qualified_gain ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art416_qualified_gain ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art416_qualified_gain ?Defendant ) ) ) ( make-instance ?oid of art416_qualified_gain ( defendant ?Defendant ) ) )")
   (derived-class art416_qualified_gain))

([rule3_neg1-deductive] of ntm-deductive-rule
   (pos-name rule3_neg1-deductive-gen370)
   (depends-on art416_organized art416_basic)
   (implies art416_basic)
   (deductive-rule "?gen60 <- ( art416_organized ( defendant ?Defendant ) ) ( not ( art416_basic ( defendant ?Defendant ) ) ) => ( art416_basic ( defendant ?Defendant ) )")
   (production-rule "( defrule rule3_neg1-deductive-gen370 ( declare ( salience ( calc-salience art416_basic ) ) ) ( run-deductive-rules ) ( object ( name ?gen60 ) ( is-a art416_organized ) ( defendant ?Defendant ) ) ( not ( object ( is-a art416_basic ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art416_basic ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art416_basic ?Defendant ) ) ) ( make-instance ?oid of art416_basic ( defendant ?Defendant ) ) )")
   (derived-class art416_basic))

([rule3-deductive] of ntm-deductive-rule
   (pos-name rule3-deductive-gen369)
   (depends-on lc:case lc:case art416_organized)
   (implies art416_organized)
   (deductive-rule "?gen48 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ) ?gen49 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ) ( not ( art416_organized ( defendant ?Defendant ) ) ) => ( art416_organized ( defendant ?Defendant ) )")
   (production-rule "( defrule rule3-deductive-gen369 ( declare ( salience ( calc-salience art416_organized ) ) ) ( run-deductive-rules ) ( object ( name ?gen48 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ) ( object ( name ?gen49 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:organized_group \"true\" ) ) ( not ( object ( is-a art416_organized ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art416_organized ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art416_organized ?Defendant ) ) ) ( make-instance ?oid of art416_organized ( defendant ?Defendant ) ) )")
   (derived-class art416_organized))

([rule2_neg-deductive] of ntm-deductive-rule
   (pos-name rule2_neg-deductive-gen368)
   (depends-on art416_qualified_gain art416_basic)
   (implies art416_basic)
   (deductive-rule "?gen39 <- ( art416_qualified_gain ( defendant ?Defendant ) ) ( not ( art416_basic ( defendant ?Defendant ) ) ) => ( art416_basic ( defendant ?Defendant ) )")
   (production-rule "( defrule rule2_neg-deductive-gen368 ( declare ( salience ( calc-salience art416_basic ) ) ) ( run-deductive-rules ) ( object ( name ?gen39 ) ( is-a art416_qualified_gain ) ( defendant ?Defendant ) ) ( not ( object ( is-a art416_basic ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art416_basic ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art416_basic ?Defendant ) ) ) ( make-instance ?oid of art416_basic ( defendant ?Defendant ) ) )")
   (derived-class art416_basic))

([rule2-deductive] of ntm-deductive-rule
   (pos-name rule2-deductive-gen367)
   (depends-on lc:case lc:case art416_qualified_gain)
   (implies art416_qualified_gain)
   (deductive-rule "?gen27 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ) ?gen28 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ) ( not ( art416_qualified_gain ( defendant ?Defendant ) ) ) => ( art416_qualified_gain ( defendant ?Defendant ) )")
   (production-rule "( defrule rule2-deductive-gen367 ( declare ( salience ( calc-salience art416_qualified_gain ) ) ) ( run-deductive-rules ) ( object ( name ?gen27 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ) ( object ( name ?gen28 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:high_gain \"true\" ) ) ( not ( object ( is-a art416_qualified_gain ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art416_qualified_gain ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art416_qualified_gain ?Defendant ) ) ) ( make-instance ?oid of art416_qualified_gain ( defendant ?Defendant ) ) )")
   (derived-class art416_qualified_gain))

([rule1-deductive] of ntm-deductive-rule
   (pos-name rule1-deductive-gen366)
   (depends-on lc:case lc:case art416_basic)
   (implies art416_basic)
   (deductive-rule "?gen15 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ) ?gen16 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ) ( not ( art416_basic ( defendant ?Defendant ) ) ) => ( art416_basic ( defendant ?Defendant ) )")
   (production-rule "( defrule rule1-deductive-gen366 ( declare ( salience ( calc-salience art416_basic ) ) ) ( run-deductive-rules ) ( object ( name ?gen15 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:abuse_of_authority \"true\" ) ) ( object ( name ?gen16 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:crime_type \"art416\" ) ) ( not ( object ( is-a art416_basic ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat art416_basic ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat art416_basic ?Defendant ) ) ) ( make-instance ?oid of art416_basic ( defendant ?Defendant ) ) )")
   (derived-class art416_basic))

