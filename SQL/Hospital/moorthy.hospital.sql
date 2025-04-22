use hospital;
select * from appointment;

# 1 list all patient with their assigned doctor
select patient.firstname ,doctor.doctorname  from patient  
    join appointment  on patient.patientid=appointment.appointmentid 
    join doctor  on appointment.doctorid = doctor.doctorid;
    
    # 2 count the total number of appointment each doctor has 
    select doctor.doctorname,count(*)as total_appointment
      from doctor join appointment on doctor.doctorid = appointment.doctorid
             group by doctor.doctorname;
             
# 3 find all appointment scheduled in the current month
select * from appointment where  month(date)=month(curdate())
         and year(date)=year(curdate());
         
 # 4 get the list of billing item  and the number of doctor in each 
  select billing.items,count(doctor.doctorid) as total_doctor
   from billing left join doctor on billing.items=doctor.doctorid 
        group by billing.items;

#5  list patient who have made bill
select  distinct patient.firstname 
      from patient 
      join billing on patient.patientid= billing.patientid;
	
# 6 find  the total amount paid by each patient 
    select patient.firstname, sum(billing.amount) as total_paid 
    from patient join billing on patient.patientid=billing.patientid
    group by patient.firstname;
    
    #7. show doctor with upcoming appointment
    SELECT DISTINCT doctor.doctorname, doctor.specialization
FROM doctors 
JOIN appointments ON doctor.doctorid = appointment.doctorid
WHERE appointment.date > CURDATE();

#8. get patient who haven't paid any bill
select patient.firstname from patient
left join billing on patient.patientid=billing.patientid
      where billing.amount is null;
      
 #9. find the average amount paid by each patient 
 select patient.firstname,avg(billing.amount) as avg_paid from  
        patient join billing on patient.patientid=billing.patientid 
                group by patient.firstname;
                
                #10. find patient with more than 2 appointment
                select patient.firstname,count(*) as total_appointment
                  from patient  join appointment on patient.patientid=appointment.patientid
                          group by patient.firstname having total_appointment>2;
                          
# 11. show number of appointment by day
         select date(appointment.date) as date ,count(*) as total_appointment 
                  from appointment group by date(appointment.date) order by date;
                  
 #12. categories patients by total amount paid
 select patient.firstname,sum(billing.amount) as total_paid, 
	  case 
           when sum(billing.amount) >= 10000000 then 'high'
           when sum(billing.amount) >= 500000 then 'medium'
           else 'low'
           end as category
         from patient 
         join billing on patient.patientid=billing.patientid group by patient. firstname;
    select * from billing;