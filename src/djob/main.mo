import Types "./types";
import Principal "mo:base/Principal";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Option "mo:base/Option";
import Iter "mo:base/Iter";
import Bool "mo:base/Bool";
import Nat "mo:base/Nat";
import Array "mo:base/Array";

actor Djob {
    type Job = Types.Job;
    type NewJob = Types.NewJob;
    
    private stable var jobsAmount = 0;
    private stable var entries:[(Nat, Job)] = [];
    private var jobs = HashMap.HashMap<Nat, Job>(1, Nat.equal, Hash.hash);

    private func _create(owner: Principal, newJob: NewJob): Nat {
        jobsAmount += 1;
        let jobId = jobsAmount;
        let job = {
            id = jobId;
            ownerId = owner;
            title = newJob.title;
            company = newJob.company;
            location = newJob.location;
            tag = newJob.tag;
            description = newJob.description;
            salaryFloor = newJob.salaryFloor;
            salaryCeiling = newJob.salaryCeiling;
            email = newJob.email;
            isDeleted = false; 
        };

        jobs.put(jobId, job);

        return jobId;
    };

    private func _update(job: Job) {
        jobs.put(job.id, job);
    };

    private func _delete(jobId: Nat): Bool {
        switch (jobs.get(jobId)) {
            case(?job) {
                let deleted_job = {
                        id = job.id;
                        ownerId = job.ownerId;
                        title = job.title;
                        company = job.company;
                        location = job.location;
                        tag = job.tag;
                        description = job.description;
                        salaryFloor = job.salaryFloor;
                        salaryCeiling = job.salaryCeiling;
                        email = job.email;
                        isDeleted = true;
                };
                jobs.put(jobId, deleted_job);
            };
            case _ {
                return false;
            };
        };

        return true;
    }; 

    public shared(msg) func create(newJob: NewJob): async Text {
        let jobId = _create(msg.caller, newJob);
        
        return "You crate a job with id : " # Nat.toText(jobId);
    };

    public shared(msg) func update(job: Job): async Bool {
        switch (jobs.get(job.id)) {
            case (?job) {
                if (job.ownerId == msg.caller) {
                    _update(job);
                    return true;
                }
            };
            case _ {
                return false;
            };
        };

        return false;
    };

    public shared(msg) func delete(jobId: Nat): async Bool {
        switch (jobs.get(jobId)) {
            case (?job) {
                if (job.ownerId == msg.caller) {
                    return _delete(jobId);
                }
            };
            case _ {
                return false;
            };
        };

        return false;
    };

    public query func get(jobId: Nat): async ?Job {
        switch(jobs.get(jobId)) {
            case (?job) {
                if (job.isDeleted == true) {
                    return null;
                } else {
                    return ?job;
                }
            };
            case _ {
                return null;
            }
        };
    };

    public query func getAll(): async [Job] {
        var res: [Job] = [];
        for ((id, job) in jobs.entries()) {
            if (job.isDeleted == false) {
                res := Array.append<Job>(res, [job]);
            }
        };
        return res;
    };

    public query func getDeleted(): async [Job] {
        var res: [Job] = [];
        for ((id, job) in jobs.entries()) {
            if (job.isDeleted == true) {
                res := Array.append<Job>(res, [job]);
            }
        };
        return res;
    };

    public query func search(term: Text): async [Job] {
        var res: [Job] = [];
        for ((id, job) in jobs.entries()) {
            var all = job.title # " " # job.company # " " # job.description # " " # job.location;
            for (t in job.tag.vals()) {
                all := all # " " # t;
            };
            if (includesText(all, term)) {
                if (job.isDeleted == false) {
                    res := Array.append<Job>(res, [job]);
                }
            };
        };

        return res;
    };

    func includesText(string: Text, term: Text): Bool {
        let stringArray = Iter.toArray<Char>(string.chars());
        let termArray = Iter.toArray<Char>(term.chars());

        var i = 0;
        var j = 0;

        while (i < stringArray.size() and j < termArray.size()) {
            if (stringArray[i] == termArray[j]) {
                i += 1;
                j += 1;
                if (j == termArray.size()) { 
                    return true; 
                }
            } else {
                i += 1;
                j := 0;
            }
        };
        false
    };    

    public shared query(msg) func getOwnId(): async Principal { 
        msg.caller
    };

    system func preupgrade() {
        entries := Iter.toArray(jobs.entries());
    };

    system func postupgrade() {
        jobs := HashMap.fromIter<Nat, Job>(entries.vals(), 1, Nat.equal, Hash.hash);
        entries := [];
    };
};
