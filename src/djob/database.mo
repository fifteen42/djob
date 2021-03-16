import Types "./types";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Option "mo:base/Option";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Utils "./utils";

module {
    type Job = Types.Job;
    type NewJob = Types.NewJob;
    type OwnerId = Types.OwnerId;

    public class Directory() {
        let hashMap = HashMap.HashMap<Nat, Job>(1000000, isEq, Principal.hash);

        public func createOne(id: Nat, ownerId:OwnerId, job: Job) {
            hashMap.put(id, makeJob(id, ownerId, job));
        };

        public func updateOne(jobId: Nat, job: Job) {
            hashMap.put(jobId, job);
        };

        public func show(): [Job] {
            var jobs: [Job] = [];
            for ((id, job) in hashMap.entries()) {
                jobs := Array.append<Job>(jobs, [job]);
            };
            jobs
        };

        public func findBy(term: Text): [Job] {
            var jobs: [Job] = [];
            for ((id, job) in hashMap.entries()) {
                let all = job.title # " " # job.company # " " # job.description # " " # job.location;
                if (includesText(all, term)) {
                    jobs := Array.append<Job>(jobs, [job]);
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

        func makeJob(id:Nat, ownerId: Principal, job: NewJob): Job {
            {
                id = id;
                ownerId = ownerId;
                title = job.title;
                company = job.company;
                location = job.location;
                tag = job.tag;
                description = job.description;
                salaryFloor = job.salaryFloor;
                salaryCeiling = job.salaryCeiling;
                email = job.email;
            }
        };
        
    };

    func isEq(x: Nat, y: Nat): Bool { x == y };
};