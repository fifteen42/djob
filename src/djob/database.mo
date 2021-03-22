import Types "./types";
import Principal "mo:base/Principal";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Option "mo:base/Option";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Bool "mo:base/Bool";

module {
    type Job = Types.Job;
    type NewJob = Types.NewJob;
    type OwnerId = Types.OwnerId;
    type Tag = Types.Tag;

    public class Directory() {
        let hashMap = HashMap.HashMap<Nat, Job>(1, isEq, Hash.hash);

        let my_id:Text = "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe";

        public func createOne(id: Nat, job: NewJob) {
            hashMap.put(id, makeJob(id, job));
        };

        public func updateOne(jobId: Nat, job: Job) {
            hashMap.put(jobId, job);
        };

        public func findOne(jobId: Nat): ?Job {
            hashMap.get(jobId)
        };

        public func deleteOne(jobId: Nat) {
            let job = hashMap.get(jobId);
            
            switch (job) {
                case (?job) {
                    let deleted_job = {
                        id = job.id;
                        ownerId = my_id;
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
                    hashMap.put(jobId, deleted_job);
                };
                case (null) {
                    ()
                };
            };
        };
        
        // show all jobs include deleted jobs
        public func showAll(): [Job] {
            var jobs: [Job] = [];
            for ((id, job) in hashMap.entries()) {
                jobs := Array.append<Job>(jobs, [job]);
            };
            jobs
        };

        public func show(): [Job] {
            var jobs: [Job] = [];
            for ((id, job) in hashMap.entries()) {
                if (job.isDeleted == false) {
                    jobs := Array.append<Job>(jobs, [job]);
                }
            };
            jobs
        };

        public func findBy(term: Text): [Job] {
            var jobs: [Job] = [];
            for ((id, job) in hashMap.entries()) {
                let all = job.title # " " # job.company # " " # job.description # " " # job.location;
                if (includesText(all, term)) {
                    if (job.isDeleted == false) {
                        jobs := Array.append<Job>(jobs, [job]);
                    }
                };
            };
            jobs
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
                if (j == termArray.size()) { return true; }
                } else {
                i += 1;
                j := 0;
                }
            };
            false
        };

        func makeJob(id:Nat, job: NewJob): Job {
            {
                id = id;
                ownerId = my_id;
                title = job.title;
                company = job.company;
                location = job.location;
                tag = job.tag;
                description = job.description;
                salaryFloor = job.salaryFloor;
                salaryCeiling = job.salaryCeiling;
                email = job.email;
                isDeleted = false;
            }
        };
        
    };

    func isEq(x: Nat, y: Nat): Bool { x == y };
};