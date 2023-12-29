/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pack.excelexport;

import com.eminent.issue.formbean.IssueFormBean;
import java.text.SimpleDateFormat;
import java.util.Comparator;

/**
 *
 * @author admin
 */
public class IssueBean {

    public static Comparator<IssueFormBean> getComparator(ExcelexportComprator... sortParameters) {
        return new IssueComparator(sortParameters);
    }

    public enum ExcelexportComprator {

        issueid_asc, priority_asc, severity_asc, pname_asc, module_asc, Subject_asc, status_asc, due_date_asc, assignedto_asc, Age_asc, Refer_asc,
        issueid_desc, priority_desc, severity_desc, pname_desc, module_desc, Subject_desc, status_desc, due_date_desc, assignedto_desc, Age_desc, Refer_desc
    }

    private static class IssueComparator implements Comparator<IssueFormBean> {

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        private ExcelexportComprator[] parameters;

        private IssueComparator(ExcelexportComprator[] parameters) {
            this.parameters = parameters;
        }

        @Override
        public int compare(IssueFormBean objA, IssueFormBean objB) {
            int comparison;
            for (ExcelexportComprator parameter : parameters) {
                switch (parameter) {
                    case issueid_asc:
                        comparison = objA.getIssueId().compareTo(objB.getIssueId());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case issueid_desc:
                        comparison = objB.getIssueId().compareTo(objA.getIssueId());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case priority_asc:
                        comparison = objA.getPriority().compareTo(objB.getPriority());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case priority_desc:
                        comparison = objB.getPriority().compareTo(objA.getPriority());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;

                    case severity_asc:
                        comparison = objA.getSeverity().compareTo(objB.getSeverity());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case severity_desc:
                        comparison = objB.getSeverity().compareTo(objA.getSeverity());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case pname_asc:
                        comparison = objA.getpName().compareTo(objB.getpName());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case pname_desc:
                        comparison = objB.getpName().compareTo(objA.getpName());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case module_asc:
                        comparison = objA.getmName().compareTo(objB.getmName());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case module_desc:
                        comparison = objB.getmName().compareTo(objA.getmName());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;

                    case Subject_asc:
                        comparison = objA.getSubject().compareTo(objB.getSubject());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case Subject_desc:
                        comparison = objB.getSubject().compareTo(objA.getSubject());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case status_asc:
                        comparison = objA.getStatus().compareTo(objB.getStatus());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case status_desc:
                        comparison = objB.getStatus().compareTo(objA.getStatus());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case due_date_asc:
                        try {
                            comparison = sdf.parse(objA.getDueDate()).compareTo(sdf.parse(objB.getDueDate()));
                        } catch (Exception e) {
                            comparison = 0;
                            e.printStackTrace();
                        }
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case due_date_desc:
                        try {
                            comparison = sdf.parse(objB.getDueDate()).compareTo(sdf.parse(objA.getDueDate()));
                        } catch (Exception e) {
                            comparison = 0;
                            e.printStackTrace();
                        }
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case assignedto_asc:
                        comparison = objA.getAssignto().compareTo(objB.getAssignto());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case assignedto_desc:
                        comparison = objB.getAssignto().compareTo(objA.getAssignto());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case Age_asc:
                        comparison = objA.getAge() - (objB.getAge());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case Age_desc:
                        comparison = objB.getAge() - (objA.getAge());
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case Refer_asc:
                        comparison = objA.getFilecount() - objB.getFilecount();
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                    case Refer_desc:
                        comparison = objB.getFilecount() - objA.getFilecount();
                        if (comparison != 0) {
                            return comparison;
                        }
                        break;
                }
            }
            return 0;
        }

    }

    /*    
     public enum ExcelexportComprator implements  Comparator<IssueFormBean>{
     issueid {
     @Override
     public int compare(IssueFormBean objA, IssueFormBean objB) {
     return objA.getIssueId().compareTo(objB.getIssueId());
     }},
     priority {
     @Override
     public int compare(IssueFormBean objA, IssueFormBean objB) {
     return objA.getPriority().compareTo(objB.getPriority());
     }},
     severity {
     @Override
     public int compare(IssueFormBean objA, IssueFormBean objB) {
     return objA.getSeverity().compareTo(objB.getSeverity());
     }},
     pname {
     @Override
     public int compare(IssueFormBean objA, IssueFormBean objB) {
     return objA.getpName().compareTo(objB.getpName());
     }},
     module {
     @Override
     public int compare(IssueFormBean objA, IssueFormBean objB) {
     return objA.getmName().compareTo(objB.getmName());
     }},
     Subject {
     @Override
     public int compare(IssueFormBean objA, IssueFormBean objB) {
     return objA.getSubject().compareTo(objB.getSubject());
     }}, 
     status {
     @Override
     public int compare(IssueFormBean objA, IssueFormBean objB) {
     return objA.getStatus().compareTo(objB.getStatus());
     }},
     due_date {
     @Override
     public int compare(IssueFormBean objA, IssueFormBean objB) {
     return objA.getDueDate().compareTo(objB.getDueDate());
     }},
     assignedto {
     @Override
     public int compare(IssueFormBean objA, IssueFormBean objB) {
     return objA.getAssignto().compareTo(objB.getAssignto());
     }}, 
     Age {
     @Override
     public int compare(IssueFormBean objA, IssueFormBean objB) {
            
     return Integer.valueOf(objA.getAge()).compareTo(objB.getAge());
     }},
     Refer {
     @Override
     public int compare(IssueFormBean objA, IssueFormBean objB) {
     return objA.getFilecount().compareTo(objB.getFilecount());
     }};
    
     public static Comparator<IssueFormBean> decending(final Comparator<IssueFormBean> other) {
     return new Comparator<IssueFormBean>() {
     @Override
     public int compare(IssueFormBean o1, IssueFormBean o2) {
     return -1 * other.compare(o1, o2);
     }
     };
     }
     public static Comparator<IssueFormBean> ascending(final Comparator<IssueFormBean> other) {
     return new Comparator<IssueFormBean>() {
     @Override
     public int compare(IssueFormBean o1, IssueFormBean o2) {
     return other.compare(o1, o2);
     }
     };
     }
     public static Comparator<IssueFormBean> getComparator(final ExcelexportComprator... multipleOptions) {
     return new Comparator<IssueFormBean>() {
     @Override
     public int compare(IssueFormBean o1, IssueFormBean o2) {
     for (ExcelexportComprator option : multipleOptions) {
     int result = option.compare(o1, o2);
     if (result != 0) {
     return result;
     }
     }
     return 0;
     }
     };
     }
     ;
 
   
     } */
}
