========================================================================
Dynamical Fractional Order System (DFOS) Identification and Sensor Selection

========================================================================

This is a utility package developed for the identification of dynamical  fractional order system (DFOS) and sub-optimal sensor placement.
The method developed is based on the following work under review.


Vasileios Tzoumas⋆, Yuankun Xue⋄ Sergio Pequito⋆,  Paul Bogdan⋄ and George J. Pappas⋆. Selecting Sensors in Biological Fractional-Order Systems (submitted to IEEE Transactions on Control of Network Systems).

⋆ Department of Electrical and Systems Engineering, School of Engineering and Applied Science, University of Pennsylvania
⋄ USC Ming Hsieh Department of Electrical Engineering, Viterbi School of Engineering, University of Southern California



Abstract 

In this paper, we focus on sensor selection, i.e., determine the minimum number of state variables that need to be measured, to monitor the evolution of the entire biological system, i.e., all the state variables, when modeled by discrete-time fractional-order systems (DTFOS) that are subject to modeling errors, process and measurement noise. These systems are particularly relevant when modeling of spatiotemporal dynamics of processes in which the impact of long-range memory cannot be properly modeled by multivariate auto-regressive integrative moving-average models. Therefore, DTFOS enable a unified state-space framework to model the evolution of several biological (e.g., stem cell growth and bacteria evolution) and physiological signals (e.g., electroencephalogram and electromyogram).
Therefore, in this paper, we focus on the solution to four different (yet related) problems of sensor selection for DTFOS, that are motivated by constraints on the data acquisition that are enforced by the detrimental impact of the sensing mechanisms to the biological system, the cost of performing the measurements with the current sensing technology, or spatial constraints that limit the number of sensors that can be deployed. Towards determining the solution to these problems that we show to be NP-hard, we leverage the representation of the DTFOS to derive new objectives and conditions that, ultimately, enable us to efficiently approximate a solution to the different problems by exploiting the submodularity structure, which enables us to establish sub-optimality guarantees.





The system identification method is developed based on the following work:

1. Xue, Y., Pequito, S., Coelho, J. R., Bogdan, P., & Pappas, G. J. (2016, September). Minimum number of sensors to ensure observability of physiological systems: A case study. In Communication, Control, and Computing (Allerton), 2016 54th Annual Allerton Conference on (pp. 1181-1188). IEEE.

2.Xue, Yuankun, Saul Rodriguez, and Paul Bogdan. "A spatio-temporal fractal model for a CPS approach to brain-machine-body interfaces." In Design, Automation & Test in Europe Conference & Exhibition (DATE), 2016, pp. 642-647. IEEE, 2016.

3.Xue, Yuankun, and Paul Bogdan. "Constructing compact causal mathematical models for complex dynamics." In Proceedings of the 8th International Conference on Cyber-Physical Systems, pp. 97-107. ACM, 2017.


/////////////////////////////////////////////////////////////////////////////

